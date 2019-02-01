//
//  MenuSortDishesViewModel.swift
//  takeaway
//
//  Created by 徐强强 on 2018/7/2.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MenuSubGroupViewModel {
    private let navigator: MenuSubGroupNavigator
    private var groups: [GroupModel]?
    
    init(navigator: MenuSubGroupNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let loadingTracker = ActivityIndicator()
        
        let createNewGroup = input.createNewGroup
            .flatMapLatest { _ in
                self.navigator.toMenuEditGroupVC()
                    .saveData
                    .asDriverOnErrorJustComplete()
            }
        
        let renameGroup = input.cellRenameButtonTap
            .flatMapLatest { indexPath in
                self.navigator.toMenuEditGroupVC()
                    .saveData
                    .asDriverOnErrorJustComplete()
            }
        
        let getMenusInfo = Driver.merge(createNewGroup, input.viewDidLoad, renameGroup)
            .flatMapLatest { _ in
                self.getMenusInfo()
                    .trackActivity(loadingTracker)
                    .asDriver(onErrorJustReturn: self.createSectionModel())
            }
        
        let deleteSubGroups = input.cellDeleteButtonTap
            .flatMapLatest { (indexPath) -> Driver<[MenuSubGroupViewController.CellSectionModel]> in
                return self.deleteSubGroups(at: indexPath)
                    .asDriver(onErrorJustReturn: self.createSectionModel())
            }
        
        let dataSource = Driver.merge(getMenusInfo, deleteSubGroups)
        let loading = loadingTracker.asDriver()
        return Output(dataSource: dataSource, loading: loading)
    }
    
    private func getMenusInfo() -> Single<[MenuSubGroupViewController.CellSectionModel]> {
        return RxOpenAPIProvider.rx.request(.newList)
            .mapToArray(type: GroupModel.self)
            .asSingle()
            .map { result in
                self.groups = result
                return self.createSectionModel()
            }
    }
    
    private func deleteSubGroups(at indexPath: IndexPath) -> Single<[MenuSubGroupViewController.CellSectionModel]> {
        groups?.remove(at: indexPath.row);
        return Single.just(self.createSectionModel())
    }
    
    private func createSectionModel() -> [MenuSubGroupViewController.CellSectionModel] {
        if let dishGroups = self.groups, !dishGroups.isEmpty {
            return [MenuSubGroupViewController.CellSectionModel(items: dishGroups)]
        }
        return []
    }
}

extension MenuSubGroupViewModel {
    struct Input {
        let createNewGroup: Driver<Void>
        let viewDidLoad: Driver<Void>
        let cellDeleteButtonTap: Driver<IndexPath>
        let cellRenameButtonTap: Driver<IndexPath>
    }
    
    struct Output {
        let dataSource: Driver<[MenuSubGroupViewController.CellSectionModel]>
        let loading: Driver<Bool>
    }
}
