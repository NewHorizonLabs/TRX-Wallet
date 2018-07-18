//
//  TransactionDetailViewController.swift
//  TRXWallet
//
//  Created by Maynard on 2018/7/18.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit
import MBProgressHUD

class TransactionDetailViewController: UIViewController {
    
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var fromAddressLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var transactionIDLabel: WebsiteLabel!
    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    var transaction: TronTransaction?
    
    var url: String = "" {
        didSet {
            transactionIDLabel.url = URL(string: url)
            changeQRCode(address: url)
        }
    }
    
    func changeQRCode(address: String) {
        let string = address
        
        // EIP67 format not being used much yet, use hex value for now
        // let string = "ethereum:\(account.address.address)?value=\(value)"
        
        DispatchQueue.global(qos: .background).async {
            let image = self.generateQRCode(from: string)
            DispatchQueue.main.async {
                self.codeImageView.image = image
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let transaction = transaction {
            configure(model: transaction)
            if let idStirng  = transaction.rawData.data()?.sha256().hexString {
                print(idStirng)
                transactionIDLabel.text = idStirng
                url = "https://tronscan.org/#/transaction/\(idStirng)"
            }
            
        }
    }
    
    @IBAction func copyButtonClick(_ sender: Any) {
        self.copyAddress()
    }
    
    @objc func copyAddress() {
        UIPasteboard.general.string = url
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = R.string.tron.hudCopysuccess()
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    func configure(model: TronTransaction) {
        dateLabel.text = model.rawData.expiration.dateString
        if let contract = model.rawData.contractArray.firstObject as? Transaction_Contract {
            do {
                if let transferContract = try contract.parameter.unpackMessageClass(TransferContract.self) as? TransferContract {
                    DispatchQueue.main.async {
                        if let data = transferContract.ownerAddress {
                            self.fromAddressLabel.text = String(base58CheckEncoding: data)
                        }
                        if let data = transferContract.toAddress {
                            self.toAddressLabel.text = String(base58CheckEncoding: data)
                        }
                        
                        self.valueLabel.text = transferContract.amount.balanceString + " TRX"
                    }
                    
                }
                
            } catch {
                do {
                    if let transferContract = try contract.parameter.unpackMessageClass(TransferAssetContract.self) as? TransferAssetContract {
                        DispatchQueue.main.async {
                            if let data = transferContract.ownerAddress {
                                self.fromAddressLabel.text = String(base58CheckEncoding: data)
                            }
                            if let data = transferContract.toAddress {
                                self.toAddressLabel.text = String(base58CheckEncoding: data)
                            }
                            if let name = transferContract.assetName.toString() {
                                self.valueLabel.text = transferContract.amount.string + " " + name
                            } else {
                                self.valueLabel.text = transferContract.amount.string
                            }
                        }
                        
                    }
                } catch {
                    do {
                        if let transferContract = try contract.parameter.unpackMessageClass(FreezeBalanceContract.self) as? FreezeBalanceContract {
                            DispatchQueue.main.async {
                                if let data = transferContract.ownerAddress {
                                    self.fromAddressLabel.text = String(base58CheckEncoding: data)
                                }
                                self.toAddressLabel.text = "Frozzen"
                                self.valueLabel.text = transferContract.frozenBalance.balanceString + " TRX"
                            }
                        }
                        
                    } catch {
                        do {
                            if let transferContract = try contract.parameter.unpackMessageClass(VoteWitnessContract.self) as? VoteWitnessContract {
                                
                            }
                            
                        } catch {
                            
                        }
                    }
                }
            }
        }
    }

}
