//
//  WalletModeView.swift
//  Wallet
//
//  Created by Maynard on 2018/6/8.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxGesture

class WalletModeView: UIView, XibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var state: WalletModeState = .watch {
        didSet {
            backgroundColor = state.stateColor
            titleLabel.text = state.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        state = .watch
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    
    @objc func tapView() {
        guard !(CurrentControllerHelper.currentViewController() is BrowserViewController)  else {
            return
        }
        BrowserHelper.show(url: state.url)
    }

}

enum WalletModeState {
    case hot
    case cold
    case watch
    
    var stateColor: UIColor {
        switch self {
        case .cold:
            return UIColor.colorWithHex(hex: "#FF4FA2")
        case .watch:
            return UIColor.colorWithHex(hex: "#00D3ED")
        default:
            return UIColor.clear
        }
    }
    
    var title: String {
        switch self {
        case .cold:
            return R.string.tron.coldWalletColdTitle()
        case .watch:
            return R.string.tron.coldWalletWatchTitle()
        default:
            return ""
        }
    }
    
    var url: URL {
        let path = Bundle.main.bundlePath
        let basePath = "\(path)/html/coldwallet.html"
        return URL(fileURLWithPath: basePath, isDirectory: true)
    }
    
}

