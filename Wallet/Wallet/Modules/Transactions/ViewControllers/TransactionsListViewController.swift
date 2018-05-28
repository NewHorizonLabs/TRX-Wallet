//
//  TransactionsListViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/9.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UITableView_FDTemplateLayoutCell
import DZNEmptyDataSet

class TransactionsListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var data: Variable<[TronTransaction]> = Variable([])
    var firstLoad: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.tron.transactionNavTitle()
        tableView.register(R.nib.transactionTableViewCell)
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.transactionTableViewCell.identifier, cellType: TransactionTableViewCell.self)) { _, model, cell in
            cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TronTransaction.self).subscribe(onNext: {[weak self] (model) in
        }).disposed(by: disposeBag)
        loadData()
        
        ServiceHelper.shared.walletChange
        .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.loadData()
            })
        .disposed(by: disposeBag)
        
        tableView.addRefreshHeader {[weak self] in
            self?.firstLoad = true
            self?.tableView.reloadData()
            self?.loadData()
        }
    }
    
    func loadData() {
        guard let account = ServiceHelper.shared.account.value else {
            return
        }
        displayLoading()
        ServiceHelper.shared.getTransactions(account: account)
            .subscribe {[weak self] (list) in
                self?.firstLoad = false
                if let array = list.element {
                    let value = array.filter({ (action) -> Bool in
                        if let object = action.rawData.contractArray.firstObject as? Transaction_Contract {
                            return object.type == Transaction_Contract_ContractType.transferContract || object.type == Transaction_Contract_ContractType.transferAssetContract
                        }
                        return false
                    })
                    self?.data.value = value
                } else {
                    self?.tableView.reloadData()
                }
                self?.hideLoading()
                
                self?.tableView.endRefresh()
                
        }.disposed(by: disposeBag)
        
    }
}

extension TransactionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = data.value[indexPath.row]
        return tableView.fd_heightForCell(withIdentifier: R.nib.transactionTableViewCell.identifier, configuration: { (cell) in
            if let cell = cell as? TransactionTableViewCell {
                cell.configure(model: model)
            }
        })
    }
}

extension TransactionsListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSMutableAttributedString(string: "No Transactions", attributes: [NSAttributedStringKey.foregroundColor:UIColor.disabledTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        return string
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.transaction_empty()
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !firstLoad
    }
    
    
}
