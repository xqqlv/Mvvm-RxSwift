//
//  ConstraintView+Extension.swift
//  MvvmDemo
//
//  Created by 徐强强 on 2019/2/1.
//  Copyright © 2019年 徐强强. All rights reserved.
//

import Foundation
import SnapKit

public extension ConstraintView {
    var safeSnp: ConstraintAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}
