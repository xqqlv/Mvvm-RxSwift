//
//  ObservableConvertibleType+Extension.swift
//  takeaway
//
//  Created by 白天伟 on 2018/7/13.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}
