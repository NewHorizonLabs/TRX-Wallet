//
//  BaseTabbarViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/6/8.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire

class BaseTabbarViewController: UITabBarController {
    
    let disposeBag = DisposeBag()
    var modeView: WalletModeView = WalletModeView.loadXib()
    var state: WalletModeState = .hot {
        didSet {
            ServiceHelper.shared.walletMode = state
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(modeView)
        delegate = self
        let height = UIApplication.shared.statusBarFrame.height
        
        setStatusBar(hide: true)
        modeView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(height)
        }
        
        ServiceHelper.shared.walletChange
        .asObservable()
        .subscribe(onNext: {[weak self] _ in
            self?.updateUI()
        })
        .disposed(by: disposeBag)
        
        NetworkHelper.shared.netState.asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.updateUI()
            })
        .disposed(by: disposeBag)
        
    }
    
    func updateUI() {
        let netState = NetworkHelper.shared.netState.value
        if let wallet = ServiceHelper.shared.currentWallet {
            if wallet.isWatch {
                modeView.state = .watch
                state = .watch
                setStatusBar(hide: true)
            } else {
                switch netState {
                case .notReachable, .unknown:
                    modeView.state = .cold
                    state = .cold
                    setStatusBar(hide: true)
                case .reachable:
                    modeView.state = .hot
                    state = .hot
                    setStatusBar(hide: false)
                }
            }
        }
    }
    
    func setStatusBar(hide: Bool) {
        if let statusWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? NSObject, let statusBar = statusWindow.value(forKey: "statusBar") as? UIView {
            statusBar.alpha = hide ? 0.0 : 1.0
        }
    }

}

extension BaseTabbarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch state {
        case .hot:
            return true
        default:
            if let vc = (viewController as? BaseNavigationViewController)?.viewControllers.first {
                if vc is BalanceViewController || vc is SetViewController {
                    return true
                } else {
                    HUD.showText(text: "Not avaliable in this wallet mode")
                    return false
                }
            }
            return true
        }
    }
}
