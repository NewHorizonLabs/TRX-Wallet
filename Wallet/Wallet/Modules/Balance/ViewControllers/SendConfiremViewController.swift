//
//  SendConfiremViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/12.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class SendConfiremViewController: UIViewController {

    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var senderAddressLabel: UILabel!
    
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var senderTitleLabel: UILabel!
    @IBOutlet weak var accountBalancelLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    var info:(from:String, to:String, amount: Int64)?
    
    var asset: AccountAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let info = info {
            senderAddressLabel.text = info.from
            toAddressLabel.text = info.to
            numberLabel.text = info.amount.string + "  " + (self.title ?? "")
            
        }
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        senderTitleLabel.text = R.string.tron.balanceSendConfirmSender()
        toTitleLabel.text = R.string.tron.balanceSendConfirmTo()
        balanceTitleLabel.text = R.string.tron.balanceNavTitle()
        totalTitleLabel.text = R.string.tron.balanceSendConfirmTotal()
        
        sendButton.setTitle(R.string.tron.balanceSendConfirmButtonConfirm(), for: .normal)
        
        sendButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        sendButton.setBackgroundColor(UIColor.normalBackgroundColor, forState: .normal)
        
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        if let asset = asset {
            accountBalancelLabel.text = asset.balance
        } else {
            accountBalancelLabel.text = ServiceHelper.shared.account.value?.balance.balanceString
        }
        
    }
    
    @objc func sendButtonClick() {
        if let _ = asset {
            sendOtherToken()
        } else {
            sendTRX()
        }
    }
    
    func sendTRX() {
        guard let info = info, let fromAddress = Data(base58CheckDecoding: info.from), let toAddress = Data(base58CheckDecoding: info.to) else {
            return
        }
        
        let contract = TransferContract()
        contract.ownerAddress = fromAddress
        contract.toAddress = toAddress
        contract.amount = info.amount * 1000000
        self.displayLoading()
        ServiceHelper.shared.service.createTransaction(withRequest: contract) {[weak self] (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (result, error) in
                    if let response = result {
                        let success = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        if success {
                            self?.hideLoading()
                            HUD.showText(text: R.string.tron.hudSuccess())
                            self?.dismiss(animated: true, completion: nil)
                        } else {
                            //                            self?.displayError(error: Error())
                            self?.hideLoading()
                            HUD.showError(error: response.errorMessage)
                        }
                        
                    }
                })
            } else if let error = error {
                self?.displayError(error: error)
            }
        }
    }
    
    func sendOtherToken() {
        guard let info = info, let asset = asset, let fromAddress = Data(base58CheckDecoding: info.from), let toAddress = Data(base58CheckDecoding: info.to) else {
            return
        }
        
        let contract = TransferAssetContract()
        contract.ownerAddress = fromAddress
        contract.toAddress = toAddress
        contract.amount = info.amount
        contract.assetName = asset.name.data(using: .utf8)
        self.displayLoading()
    
        ServiceHelper.shared.service.transferAsset(withRequest: contract) {[weak self] (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (result, error) in
                    if let response = result {
                        let success = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        if success {
                            self?.hideLoading()
                            HUD.showText(text: R.string.tron.hudSuccess())
                            self?.dismiss(animated: true, completion: nil)
                        } else {
                            //                            self?.displayError(error: Error())
                            self?.hideLoading()
                            HUD.showError(error: response.errorMessage)
                        }
                        
                    }
                })
            } else if let error = error {
                self?.displayError(error: error)
            }
        }
    }

}
