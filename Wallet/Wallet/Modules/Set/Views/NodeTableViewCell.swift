//
//  NodeTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/6/15.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit

class NodeTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var portLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            super.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }
    
    func configure(model: Node) {
        addressLabel.text = model.address.host.toString()
        portLabel.text = String(model.address.port)
    }
    
}
