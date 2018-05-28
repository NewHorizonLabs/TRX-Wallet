//
//  VoteViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UITableView_FDTemplateLayoutCell

class VoteViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var data: Variable<[Witness]> = Variable([])
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.tron.voteNavTitle()
        tableView.register(R.nib.voteTableViewCell)
        tableView.delegate = self
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.voteTableViewCell.identifier, cellType: VoteTableViewCell.self)) { _, model, cell in
            cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        loadData()
        tableView.addRefreshHeader {[weak self] in
            self?.loadData()
        }
    }
    
    func loadData() {
        displayLoading()
        ServiceHelper.shared.service.listWitnesses(withRequest: EmptyMessage()) {[weak self] (list, error) in
            if let array = list?.witnessesArray as? [Witness] {
                self?.data.value = array
            }
            self?.hideLoading()
            self?.tableView.endRefresh()
        }
    }

}

extension VoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = data.value[indexPath.row]
        return tableView.fd_heightForCell(withIdentifier: R.nib.voteTableViewCell.identifier, configuration: { (cell) in
            if let cell = cell as? VoteTableViewCell {
                cell.configure(model: model)
            }
        })
    }
}
