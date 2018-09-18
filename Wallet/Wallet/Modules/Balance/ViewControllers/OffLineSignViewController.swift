//
//  OffLineSignViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/31.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit

class OffLineSignViewController: UIViewController {

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
    
    var toSignTransaction: TronTransaction?
    
    var asset: AccountAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let info = info {
            senderAddressLabel.text = info.from
            toAddressLabel.text = info.to
            numberLabel.text = info.amount.string + "  " + (self.title ?? "")
        }
        
        configureUI()
        if let action = toSignTransaction {
            updateUI(action)
        }
        // Do any additional setup after loading the view.
    }
    
    func updateUI(_ transaction: TronTransaction) {
        if let contract = transaction.rawData.contractArray.firstObject as? Transaction_Contract {
                do {
                    if let transferContract = try contract.parameter.unpackMessageClass(TransferContract.self) as? TransferContract {
                        DispatchQueue.main.async {
                            self.toAddressLabel.text = transferContract.toAddress.addressString
                            self.senderAddressLabel.text = transferContract.ownerAddress.addressString
                            self.numberLabel.text = transferContract.amount.balanceString
                        }
                    }
                } catch {
                    self.sendButtonClick()
            }
        }
    }
    
    func configureUI() {
        senderTitleLabel.text = R.string.tron.balanceSendConfirmSender()
        toTitleLabel.text = R.string.tron.balanceSendConfirmTo()
        balanceTitleLabel.text = R.string.tron.balanceNavTitle()
        totalTitleLabel.text = R.string.tron.balanceSendConfirmTotal()
        
        sendButton.setTitle(R.string.tron.coldWalletSignTitle(), for: .normal)
        
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
        guard let transaction = toSignTransaction else {
            HUD.showText(text: "No transaction")
            return
        }
        if let signedTransaction = ServiceHelper.transactionSign(transaction) {
            let view = SignedTransactionView.loadXib()
            view.popShow()
            view.finishBlock = {
                self.dismiss(animated: true, completion: nil)
            }
            if let dataString = signedTransaction.data()?.hexString {
                view.changeQRCode(address: dataString)
            }
        } else {
            HUD.showError(error: "Sign Transaction Failed")
        }
    }
    
}
