//
//  LoginHomeViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/11.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import TrustCore
import TrustKeystore
class LoginHomeViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: NavCancelButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    var coordinator: WalletCoordinator?
    
    
    override var hideNavigationBar: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.flat = true
        coordinator = WalletCoordinator.init(navigationController: self.navigationController as! NavigationController, keystore: EtherKeystore.shared)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonClick), for: .touchUpInside)
        configureUI()
        if EtherKeystore.shared.wallets.count > 0 {
            self.cancelButton.isHidden = false
        } else {
            self.cancelButton.isHidden = true
        }
        loginButton.setTitle(R.string.tron.loginImportButtonTitle(), for: .normal)
        createButton.setTitle(R.string.tron.loginCreateButtonTitle(), for: .normal)
    }
    
    func configureUI() {
        createButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        loginButton.setTitleColor(UIColor.mainNormalColor, for: .normal)
        loginButton.pborderColor = UIColor.mainNormalColor
        loginButton.pborderWidth = 0.5
    }
    
    @objc func createButtonClick() {
        let vc = R.storyboard.login.createWalletViewController()!
        vc.coordinator = self.coordinator
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func loginButtonClick() {
        self.coordinator?.delegate = self
        self.coordinator?.pushImportWallet()
    }

    func showHomePage() {
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = R.storyboard.main.instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}

extension LoginHomeViewController: WalletCoordinatorDelegate {
    func didCancel(in coordinator: WalletCoordinator) {
        showHomePage()
    }
    
    func didFinish(with account: Wallet, in coordinator: WalletCoordinator) {
        ServiceHelper.shared.reset(wallet: account)
        showHomePage()
    }
}
