//
//  MenuSortDishesNavigator.swift
//  takeaway
//
//  Created by 徐强强 on 2018/7/2.
//  Copyright © 2018年 zaihui. All rights reserved.
//

class MenuSubGroupNavigator: BaseNavigator {
    
    func toMenuEditGroupVC() -> MenuEditGroupViewController {
        let navigator = MenuEditGroupNavigator(navigationController: navigationController)
        let viewModel = MenuEditGroupViewModel(navigator: navigator)
        let vc = MenuEditGroupViewController()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
        return vc
    }
}
