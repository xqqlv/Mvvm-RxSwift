//
//  BaseViewController.swift
//  takeaway
//
//  Created by 徐强强 on 2018/1/24.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var keyboardAnimationDuration: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        autoLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false

        if #available(iOS 11.0, *) {

        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

    func setupUI() {

    }

    func autoLayout() {

    }
}
