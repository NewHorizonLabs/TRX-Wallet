//
//  SetSwitchTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/5/22.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class SetSwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var controlSwitch: UISwitch!
    
    var switchBlock: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        controlSwitch.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged() {
        switchBlock?(controlSwitch.isOn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            super.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }
    
}
