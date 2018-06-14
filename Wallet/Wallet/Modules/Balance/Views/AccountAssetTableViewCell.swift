//
//  AccountAssetTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/5/9.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AccountAssetTableViewCell: UITableViewCell {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        priceLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            super.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }
    
    func configure(model: AccountAsset) {
        nameLabel.text = model.name
        balanceLabel.text = model.balance
        loadDetail(model: model)
    }
    
    func loadDetail(model: AccountAsset) {
        let message = BytesMessage()
        if let data = model.name.data(using: .utf8) {
            message.value = data
            
            ServiceHelper.shared.service.getAssetIssueByName(withRequest: message) {[weak self] (result, error) in
                if let result = result, let string = result.name.toString(), string == model.name {
                    self?.priceLabel.text = String(Float(result.trxNum.trxValue) * Float(model.balance)! / Float(result.num)) + "TRX"
                }
            }
        }
        
    }
    
}
