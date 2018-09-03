//
//  TransactionTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var fromTitleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var fromAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fromTitleLabel.text = R.string.tron.transactionFromLabelTitle()
        toTitleLabel.text = R.string.tron.transactionToLabelTitle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.fromAddressLabel.text = ""
        self.toAddressLabel.text = ""
        self.dateLabel.text = ""
        self.valueLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            super.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }
    
    func configure(model: TransactionModel) {
        self.dateLabel.text = model.timestamp?.dateString
        self.fromAddressLabel.text = model.ownerAddress
        self.toAddressLabel.text = model.toAddress
        guard let value = model.contractData?.amount else {
            return
        }
        if let token = model.contractData?.token {
            self.valueLabel.text = "\(value.toString() ?? "0")" + " \(token)"
        } else {
            self.valueLabel.text = "\(value.trxValue.toString() ?? "0")" + " TRX"
        }
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
