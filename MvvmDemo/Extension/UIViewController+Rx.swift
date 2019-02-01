//
//  UIViewController+Rx.swift
//  takeaway
//
//  Created by 徐强强 on 2018/8/8.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    var isLoading: Binder<Bool> {
        return Binder(base, binding: { (vc, result) in
            if result {
                vc.showLoading()
            } else {
                vc.hideLoading()
            }
        })
    }
    
    var viewWillAppear: Driver<Void> {
        return sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map({_ in})
            .asDriver(onErrorJustReturn: ())
    }
    
    var viewWillDisappear: Driver<Void> {
        return sentMessage(#selector(UIViewController.viewWillDisappear(_:)))
            .map({_ in})
            .asDriver(onErrorJustReturn: ())
    }
}
