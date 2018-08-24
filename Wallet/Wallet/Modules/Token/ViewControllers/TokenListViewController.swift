//
//  TokenViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UITableView_FDTemplateLayoutCell

class TokenListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    let disposeBag = DisposeBag()
    
    var data: Variable<[AssetIssueContract]> = Variable([])

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.tron.tokenNavTitle()
        tableView.register(R.nib.tokenTableViewCell)
        tableView.delegate = self
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.tokenTableViewCell.identifier, cellType: TokenTableViewCell.self)) { _, model, cell in
                cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        loadData()
        
        ServiceHelper.shared.tokenChange
        .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.loadData()
            })
        .disposed(by: disposeBag)
        tableView.addRefreshHeader {[weak self] in
            self?.loadData()
        }
        
        //冷钱包隐藏添加按钮
        ServiceHelper.shared.isWatchMode.asObservable()
        .bind(to: addButton.rx.isHidden)
        .disposed(by: disposeBag)
        
        self.view.backgroundColor = UIColor.backgroundColor
        self.tableView.backgroundColor = UIColor.backgroundColor
    }
    
    func loadData() {
        displayLoading()
        ServiceHelper.shared.service.getAssetIssueList(withRequest: EmptyMessage()) {[weak self] (list, error) in
            if let array = list?.assetIssueArray as? [AssetIssueContract] {
                self?.data.value = array
            }
            self?.hideLoading()
            self?.tableView.endRefresh()
        }
    }

}

extension TokenListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let model = data.value[indexPath.row]
//        return tableView.fd_heightForCell(withIdentifier: R.nib.tokenTableViewCell.identifier, configuration: { (cell) in
//            if let cell = cell as? TokenTableViewCell {
//                cell.configure(model: model)
//            }
//        })
//        
//    }
}
