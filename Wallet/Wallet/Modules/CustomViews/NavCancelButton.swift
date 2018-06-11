//
//  NavCancelButton.swift
//  Wallet
//
//  Created by Maynard on 2018/3/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class NavCancelButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfigure()
        self.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    func baseConfigure() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.titleLabel?.textColor = UIColor.colorWithHex(hex: "#212837")
        self.setTitle(R.string.tron.navButtonCancel(), for: .normal)
    }
    
    @objc func buttonClick() {
        CurrentControllerHelper.currentViewController().dismiss(animated: true, completion: nil)
    }
}
