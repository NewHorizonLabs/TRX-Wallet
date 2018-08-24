//
//  VoteTipView.swift
//  TRXWallet
//
//  Created by Maynard on 2018/8/24.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit

class VoteTipView: UIView {
    var backImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.vote_tip_bg())
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = R.string.tron.voteYourvoteLabelTitle()
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfigure()
    }
    
    func baseConfigure() {
        addSubview(backImageView)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-2)
        }
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
}
