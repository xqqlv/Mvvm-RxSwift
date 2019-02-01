//
//  DishesEditGroupViewController.swift
//  takeaway
//
//  Created by 徐强强 on 2018/1/17.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MenuEditGroupViewController: BaseViewController {
    
    var viewModel: MenuEditGroupViewModel!
    var saveData = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: nil, action: nil)
        self.bindViewModel()
    }
    
    func bindViewModel() {
        navigationItem.rightBarButtonItem!.rx.tap
            .asDriver()
            .drive(saveData)
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem!.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }

}
