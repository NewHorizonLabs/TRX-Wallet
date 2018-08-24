//
//  TokenTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum TokenState {
    case notStart
    case normal
    case finished
}

class TokenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var participateButton: UIButton!
    @IBOutlet weak var tokenNameTitleLabel: UILabel!
    
    @IBOutlet weak var issuerTitleLabel: UILabel!
    var model: AssetIssueContract?
    
    var disposeBag = DisposeBag()
    let cellDisposeBag = DisposeBag()
    
    var state: TokenState = .notStart {
        didSet {
            switch state {
            case .notStart:
                participateButton.isEnabled = false
                participateButton.setTitle(R.string.tron.tokenNotstartButtonTitle(), for: .normal)
            case .normal:
                participateButton.isEnabled = true
                participateButton.setTitle(R.string.tron.tokenParticipateButtonTitle(), for: .normal)
            case .finished:
                participateButton.isEnabled = false
                participateButton.setTitle(R.string.tron.tokenFinishedButtonTitle(), for: .normal)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ServiceHelper.shared.isWatchMode.asObservable()
        .bind(to: participateButton.rx.isHidden)
        .disposed(by: cellDisposeBag)
        // Initialization code
        configureUI()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            super.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }
    
    func configureUI() {
        totalTitleLabel.text = R.string.tron.tokenTotalsupplyLabelTitle()
        tokenNameTitleLabel.text = R.string.tron.tokenNameLabelTitle()
        issuerTitleLabel.text = R.string.tron.tokenIssuerLabelTitle()
        participateButton.setTitle(R.string.tron.tokenParticipateButtonTitle(), for: .normal)
        
        participateButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        participateButton.setBackgroundColor(UIColor(hex: "d8d8d8"), forState: .disabled)
        participateButton.addTarget(self, action: #selector(participateClick), for: .touchUpInside)
    }
    
    @objc func participateClick() {
        let purchaseView = TokenPurchaseView.loadXib()
        purchaseView.model = model
        purchaseView.popShow()
    }
    
    func configure(model: AssetIssueContract) {
        self.model = model
        nameLabel.text = model.name.toString()
        userAddressLabel.text = model.ownerAddress.addressString
        totalLabel.text = String(model.totalSupply).hanleNumbers()
        dateLabel.text = Date(timeIntervalSince1970: TimeInterval.init(model.startTime/1000)).formatterString + "-" + Date(timeIntervalSince1970: TimeInterval.init(model.endTime/1000)).formatterString
        let currentInterval = Double(Date().timeIntervalSince1970) * 1000
        if currentInterval < Double(model.startTime) {
            state = .notStart
        } else if currentInterval > Double(model.endTime) {
            state = .finished
        } else {
            state = .normal
        }
        
        let a = TronAccount()
        a.address = model.ownerAddress
        ServiceHelper.shared.getAccount(account: a)
            .asObservable()
            .subscribe(onNext: {[weak self] (account) in
                if let value = account.assetArray.filter({ (asset) -> Bool in
                    return asset.name == model.name.toString() ?? ""
                }).first {
                    if let balance = Int(value.balance), balance <= 0 {
                        self?.state = .finished
                    }
                }
                
            })
            .disposed(by: disposeBag)
    }
    
}

extension String {
//    - (void)hanleNums:(NSString *)numbers{
//    NSString *str = [numbers substringWithRange:NSMakeRange(numbers.length%3, numbers.length-numbers.length%3)];
//    NSString *strs = [numbers substringWithRange:NSMakeRange(0, numbers.length%3)];
//    for (int  i =0; i < str.length; i =i+3) {
//    NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
//    strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
//    }
//    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
//    strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
//    }
//    }
    func hanleNumbers() -> String {
        
        let count = self.count
        guard count > 3 else {
            return self
        }
        let str = self.substring(with: count%3..<count)
        var strs = self.substring(with: 0..<count%3)
        
        let delta = 3
        for index in stride(from: 0, to: str.count, by: delta) {
            let sss = str.substring(with: index..<index+3)
            strs = strs.appending(",\(sss)")
        }
        if strs.substring(with: 0..<1) == "," {
            strs = strs.substring(with: 1..<strs.count)
        }
        return strs
    }
    
}
