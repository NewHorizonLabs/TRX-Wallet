//
//  NodeListViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/6/15.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NodeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var data: Variable<[Node]> = Variable([])
    let disposeBag = DisposeBag()

    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.tron.settingNodelistNavTitle()
        resetButton.setTitle("Input Node", for: .normal)
        tableView.register(R.nib.nodeTableViewCell)
        
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.nodeTableViewCell.identifier, cellType: NodeTableViewCell.self)) { _, model, cell in
            cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Node.self).subscribe(onNext: {[weak self] (model) in
            self?.selectCell(model: model)
        }).disposed(by: disposeBag)
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func resetTodefault(_ sender: Any) {
        UserDefaults.Set.set(ServiceHelper.fullNode, forKey: .fullnode)
        ServiceHelper.shared.updateNode()
//        self.navigationController?.popViewController(animated: true)
    }
    
    func selectCell(model: Node) {
        let alert = UIAlertController(title: R.string.tron.alertChangeNodeTitle(), message: nil, preferredStyle: .alert)
        let sureAction =  UIAlertAction(title: R.string.tron.alertChangeNodeSure(), style: .default) { (action) in
            self.changeNode(model: model)
        }
        let cancelAction = UIAlertAction(title: R.string.tron.alertChangeNodeCancel(), style: .cancel) { (action) in
            
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
       
    }
    
    func changeNode(model: Node) {
        if let host = model.address.host.toString() {
            let port = String(model.address.port)
            UserDefaults.Set.set("\(host):50051", forKey: .fullnode)
            ServiceHelper.shared.updateNode()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func loadData() {
        displayLoading()
        ServiceHelper.shared.service.listNodes(withRequest: EmptyMessage()) {[weak self] (list, error) in
            if let array = list?.nodesArray as? [Node] {
                self?.data.value = array
            }
            self?.hideLoading()
        }
    }

}
