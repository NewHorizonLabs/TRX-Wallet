//
//  VoteTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VoteTableViewCell: UITableViewCell {

    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var voteTitleLabel: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var voteNumberLabel: UILabel!
    @IBOutlet weak var voteNumberTitleLabel: UILabel!
    var model: Witness?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var yourVoteNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ServiceHelper.shared.isWatchMode.asObservable()
            .bind(to: voteButton.rx.isHidden)
            .disposed(by: disposeBag)
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
        voteButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        voteButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        voteTitleLabel.text = R.string.tron.voteVoteLabelTitle()
        voteButton.setTitle(R.string.tron.voteButtonTitle(), for: .normal)
        addressTitleLabel.text = R.string.tron.voteAddressLabelTitle()
    }
    
    func configure(model: Witness) {
        self.model = model
        addressLabel.text = model.address.addressString
        voteNumberLabel.text = String(model.voteCount)
        websiteLabel.text = model.url
        if let vote = (ServiceHelper.shared.voteArray.filter { (object) -> Bool in
            return object.voteAddress.addressString == model.address.addressString
        }).first {
            yourVoteNumberLabel.text = vote.voteCount.string
            voteNumberTitleLabel.text = R.string.tron.voteYourvoteLabelTitle()
            voteNumberTitleLabel.isHidden = false
            yourVoteNumberLabel.isHidden = false
        } else {
            voteNumberTitleLabel.isHidden = true
            yourVoteNumberLabel.isHidden = true
        }
    }
    
    @objc func buttonClick() {
        let voteView = VoteInputView.loadXib()
        voteView.model = model
        voteView.popShow()
        voteView.successBlock = {[weak self] number in
            self?.votedSuccess(number: number)
        }
    }
    
    func votedSuccess(number: Int64) {
        if let model = model {
            model.voteCount = model.voteCount + number
            configure(model: model)
        }
    }
}
