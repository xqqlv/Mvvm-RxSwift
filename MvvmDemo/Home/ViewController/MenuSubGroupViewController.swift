//
//  DishesSubGroupManageViewController.swift
//  takeaway
//
//  Created by 徐强强 on 2018/1/17.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MenuSubGroupViewController: BaseViewController {
    var viewModel: MenuSubGroupViewModel!

    private let cellDeleteButtonTap = PublishSubject<IndexPath>()
    private let cellRenameButtonTap = PublishSubject<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分组管理"
        self.bindViewModel()
    }

    // MARK: - setupUI && autoLayout

    override func setupUI() {
        view.addSubview(tableView)
        view.addSubview(tabBar)
        tabBar.addSubview(createGroupButton)
    }

    override func autoLayout() {

        tabBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeSnp.bottom).offset(-49)

        }

        createGroupButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
            make.top.equalTo(0.5)
        }

        tableView.snp.makeConstraints { [unowned self] (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.tabBar.snp.top)
        }
    }
    
    func bindViewModel() {
        let viewDidLoad = Driver<Void>.just(())
        let input = MenuSubGroupViewModel.Input(createNewGroup: createGroupButton.rx.tap.asDriver(),
                                                viewDidLoad: viewDidLoad,
                                                cellDeleteButtonTap: cellDeleteButtonTap.asDriverOnErrorJustComplete(),
                                                cellRenameButtonTap: cellRenameButtonTap.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input: input)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        output.dataSource
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    // MARK: - setter && getter

    private lazy var tabBar: UIView = {
        let tabBar = UIView()
        tabBar.backgroundColor = .white
        let lineView = UIView(frame: CGRect(x: 0,
                y: 0,
                width: self.view.frame.size.width,
                height: 0.5))
        lineView.backgroundColor = UIColor.gray
        tabBar.addSubview(lineView)

        return tabBar
    }()

    private lazy var createGroupButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0,
                y: 0.5,
                width: self.view.frame.size.width,
                height: 44)
        button.setImage(UIImage(named: "goods_manage_add_icon"), for: .normal)
        button.setTitle("新建分组", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layoutButton(edgeInsetsStyle: .left, imageTitleSpace: 8)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        let headerView = UIView(frame: CGRect(x: 0,
                y: 0,
                width: self.view.frame.size.width,
                height: 16))
        tableView.tableHeaderView = headerView
        tableView.register(LabelButtonCell.self, forCellReuseIdentifier: "LabelButtonCell")
        return tableView
    }()
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<CellSectionModel> = {
        return RxTableViewSectionedReloadDataSource<CellSectionModel>(configureCell: { [weak self](_, tableView, indexPath, item) -> UITableViewCell in
            let cell: LabelButtonCell = tableView.dequeueReusableCell(withIdentifier: "LabelButtonCell") as! LabelButtonCell
            cell.data = (item.name ?? "", "", "删除", "重命名")
            cell.rightButton1.rx.tap
                .subscribe(onNext: { [weak self] (_) in
                    self?.cellDeleteButtonTap.onNext(indexPath)
                })
                .disposed(by: cell.disposeBag)
            cell.rightButton2.rx.tap
                .subscribe(onNext: { [weak self] (_) in
                    self?.cellRenameButtonTap.onNext(indexPath)
                })
                .disposed(by: cell.disposeBag)
            return cell
        })
    }()
}

// MARK: - UITableViewDelegate

extension MenuSubGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MenuSubGroupViewController {
    struct CellSectionModel {
        var items: [Item]
    }
}

extension MenuSubGroupViewController.CellSectionModel: SectionModelType {
    typealias Item = GroupModel
    init(original: MenuSubGroupViewController.CellSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
