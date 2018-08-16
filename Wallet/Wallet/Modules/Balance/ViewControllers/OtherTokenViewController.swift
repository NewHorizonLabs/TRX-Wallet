//
//  OtherTokenViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/15.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class OtherTokenViewController: UIViewController {

    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var asset: AccountAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.view.backgroundColor = UIColor.backgroundColor
        sendButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        receiveButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        
        if let asset = asset {
            title = asset.name
            nameLabel.text = asset.name
            amountLabel.text = asset.balance
        }
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        receiveButton.addTarget(self, action: #selector(receiveButtonClick), for: .touchUpInside)
    }
    
    @objc func sendButtonClick() {
        let vc = R.storyboard.balance.sendTransactionViewController()!
        vc.asset = self.asset
        let nav = BaseNavigationViewController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func receiveButtonClick() {
        let vc = R.storyboard.balance.receiveViewController()!
        let nav = BaseNavigationViewController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

}
