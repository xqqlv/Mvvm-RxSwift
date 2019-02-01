//
//  BaseNavigator.swift
//  takeaway
//
//  Created by 白天伟 on 2018/6/13.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
