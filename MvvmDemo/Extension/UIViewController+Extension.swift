//
//  UIViewController+Extension.swift
//  takeaway
//
//  Created by 徐强强 on 2018/1/23.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit

// MARK: - show and hide loading,noDataView,noNetView

extension UIViewController {
    
    func showLoading(text: String? = nil) {
        LoadingView.show(text: text,
                         enable: false,
                         superView: self.view)
    }
    
    func hideLoading() {
        LoadingView.hide(from: self.view)
    }
}
