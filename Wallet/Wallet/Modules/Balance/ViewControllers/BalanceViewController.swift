//
//  BalanceViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/7.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BalanceViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var unfrozenButton: UIButton!
    @IBOutlet weak var frozenButton: UIButton!
    @IBOutlet weak var frozenLabel: UILabel!
    
    
    @IBOutlet weak var bandwidthTitleLabel: UILabel!
    @IBOutlet weak var frozenTitleLabel: UILabel!
    @IBOutlet weak var powerTitleLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var bandWidthLabel: UILabel!
    @IBOutlet weak var navBalanceLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    var headerViewHeight: CGFloat = 0.0
    override var hideNavigationBar: Bool {
        return true
    }
    
    let disposeBag = DisposeBag()
    
    var data: Variable<[AccountAsset]> = Variable([])
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        //配置tableview
        tableView.register(R.nib.accountAssetTableViewCell)
        tableView.delegate = self
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.accountAssetTableViewCell.identifier, cellType: AccountAssetTableViewCell.self)) { _, model, cell in
            cell.configure(model: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AccountAsset.self).subscribe(onNext: {[weak self] (model) in
            self?.showToekn(asset: model)
        }).disposed(by: disposeBag)
        
        
        ServiceHelper.shared.account
        .asObservable()
            .subscribe(onNext: {[weak self] (account) in
                if let account = account {
                    self?.update(model: account)
                }
            })
        .disposed(by: disposeBag)
        
        (frozenButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
        .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.frozenButtonClick()
            })
        .disposed(by: disposeBag)
        
        (unfrozenButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.unfrozenButtonClick()
            })
            .disposed(by: disposeBag)
    }
    
    
    func showToekn(asset: AccountAsset) {
        let vc = R.storyboard.balance.otherTokenViewController()!
        vc.asset = asset
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func frozenButtonClick() {
        let view = FrozenView.loadXib()
        view.popShow()
    }
    
    func unfrozenButtonClick() {
        let alert = UIAlertController(title: R.string.tron.alertUnFreezeTitle(), message: nil, preferredStyle: .alert)
        let sureAction =  UIAlertAction(title: R.string.tron.alertUnFreezeSure(), style: .default) { (action) in
            self.unfreeze()
        }
        let cancelAction = UIAlertAction(title: R.string.tron.alertUnFreezeCancle(), style: .cancel) { (action) in
            
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func unfreeze() {
        guard let account = ServiceHelper.shared.account.value else {
            return
        }
        let contract = UnfreezeBalanceContract()
        contract.ownerAddress = account.address
        self.displayLoading()
        ServiceHelper.shared.service.unfreezeBalance(withRequest: contract) { (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (response, error) in
                    if let response = response {
                        let result = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        print(response)
                        if result {
                            HUD.showText(text: R.string.tron.hudSuccess())
                        } else {
                            self.showUnfrezeeError()
                        }
                    } else if let error = error {
                        self.showUnfrezeeError()
                    }
                    self.hideLoading()
                })
            } else {
                self.showUnfrezeeError()
                self.hideLoading()
            }
        }
    }
    
    func showUnfrezeeError() {
        let alert = UIAlertController(title: R.string.tron.errorUnFreezeTitle(), message: R.string.tron.errorUnFreezeMessage(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: R.string.tron.errorUnFreezeOk(), style: .cancel) { (action) in
            
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //获取用户数据并刷新页面
        ServiceHelper.shared.getAccount()
    }
    
    func configureUI() {
        title = R.string.tron.balanceNavTitle()
        navBalanceLabel.text = R.string.tron.balanceNavTitle()
        powerTitleLabel.text = R.string.tron.balancePowerLabelTitle()
        frozenTitleLabel.text = R.string.tron.balanceFreezeLabelTitle()
        bandwidthTitleLabel.text = R.string.tron.balanceBandwidthLabelTitle()
        sendButton.setTitle(R.string.tron.balanceButtonSend(), for: .normal)
        receiveButton.setTitle(R.string.tron.balanceButtonReceive(), for: .normal)
        sendButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        receiveButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        
        tableView.separatorColor = UIColor.lineColor
    }
    
    func update(model: TronAccount) {
        self.data.value = model.assetArray
        self.balanceLabel.text = (Double(model.balance)/1000000.0).numberFormat()
        self.bandWidthLabel.text = model.netUsage.string
        if let array = model.frozenArray as? [Account_Frozen] {
            print(array)
            let count = array.reduce(0) { (result, value) -> Int64 in
                return value.frozenBalance + result
            }
            frozenLabel.text = count.balanceString
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if headerViewHeight == 0 {
            
        }
        headerViewHeight = kScreenWidth * 285.0/375.0
        self.updateHeaderViewHeight()
    }
    
    func updateHeaderViewHeight() {
        view.layoutIfNeeded()
        var frame = headerView.frame
        frame.size.height = backgroundImageView.frame.maxY
        headerView.frame = frame
        tableView.tableHeaderView = headerView
        let contentOffsetY = tableView.contentOffset.y
        let height = self.headerView.pheight
        print(contentOffsetY)
        if (contentOffsetY > 0) {
            
        } else {
            let frame = CGRect(x: contentOffsetY, y: contentOffsetY, width: view.frame.size.width + (-contentOffsetY) * 2, height: height + (-contentOffsetY))
            backgroundImageView.frame = frame
            gradientView.frame = frame
            headerView.clipsToBounds = false
        }
    }

}
extension BalanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let height = self.headerView.pheight
        print(contentOffsetY)
        if (contentOffsetY > 0) {
            
        } else {
            let frame = CGRect(x: contentOffsetY, y: contentOffsetY, width: view.frame.size.width + (-contentOffsetY) * 2, height: height + (-contentOffsetY))
            backgroundImageView.frame = frame
            gradientView.frame = frame
            headerView.clipsToBounds = false
        }
    }
}
