//
//  TokenPurchaseView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/9.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TokenPurchaseView: UIView, XibLoadable, Popable {
    
    @IBOutlet weak var tokenNameTitleLabel: UILabel!
    
    @IBOutlet weak var amountTitleLabel: UILabel!
    @IBOutlet weak var issuerTitleLabel: UILabel!
    
    @IBOutlet weak var accountTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var tokenNameLabel: UILabel!
    
    @IBOutlet weak var numberTipLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!

    @IBOutlet weak var tokenValueLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    var model: AssetIssueContract? {
        didSet {
            tokenNameLabel.text = model?.name.toString()
            addressLabel.text = model?.ownerAddress.addressString
            totalLabel.text = model?.totalSupply.string
            descriptionLabel.text = model?.description_p.toString()
            dateLabel.text = (model?.startTime.dateString ?? "") + (model?.endTime.dateString ?? "")
            unitLabel.text = model?.name.toString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfigure()
    }
    
    func baseConfigure() {
        tokenNameTitleLabel.text = R.string.tron.tokenNameLabelTitle()
        issuerTitleLabel.text = R.string.tron.tokenIssuerLabelTitle()
        totalTitleLabel.text = R.string.tron.tokenTotalsupplyLabelTitle()
        accountTitleLabel.text = R.string.tron.tokenPopViewAccountLabelTitle()
        amountTitleLabel.text = R.string.tron.issueTokenTokenamountLabelTitle()
        confirmButton.setTitle(R.string.tron.tokenPopViewSubmitButtonTitle(), for: .normal)
        numberTipLabel.text = R.string.tron.tokenPopViewInputTitle()
        
        confirmButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        confirmButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        numberTipLabel.textColor = UIColor.mainNormalColor
        
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        balanceLabel.text = ServiceHelper.shared.balance + "TRX"
        (textField.rx.text).map { return Float($0 ?? "0") }
        .asObservable()
            .subscribe(onNext: {[weak self] (value) in
                if let value = value {
                    self?.updateExchange(value: value)
                }
                else {
                    self?.tokenValueLabel.text = "=0.0 TRX"
                }
            })
        .disposed(by: disposeBag)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        (textField.rx.text).orEmpty.map { return $0.count > 0 }
        .asObservable()
        .bind(to: numberTipLabel.rx.isHidden)
        .disposed(by: disposeBag)
    }
    
    @objc func confirmButtonClick() {
        guard let model = model, let account = ServiceHelper.shared.account.value, let text = textField.text, let number = Float(text) else {
            return
        }
        self.textField.resignFirstResponder()
        
        let contract = ParticipateAssetIssueContract()
        contract.ownerAddress = account.address
        contract.toAddress = model.ownerAddress
        contract.amount = Int64(number * (Float(model.trxNum) / Float(model.num)))
        contract.assetName = model.name
        self.viewController()?.displayLoading()
        ServiceHelper.shared.service.participateAssetIssue(withRequest: contract) { (transaction ,error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (result, error) in
                    if let response = result {
                        let result = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        if result {
                            self.popDismiss()
                            HUD.showText(text: R.string.tron.hudSuccess())
                        } else {
                            HUD.showError(error: response.errorMessage)
                        }
                    }
                    self.viewController()?.hideLoading()
                })
            } else if let error = error {
                HUD.showError(error: error.localizedDescription)
            }
        }

    }
    
    func updateExchange(value: Float) {
        if let ratio = model?.trxNum.trxValue, let tokenValue = model?.num {
            tokenValueLabel.text = "=\(value * Float(ratio) / Float(tokenValue)) TRX"
        }
    }
    
    @objc func closeButtonClick() {
        popDismiss()
    }
}
