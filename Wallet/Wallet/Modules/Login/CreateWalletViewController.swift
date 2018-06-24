//
//  CreateWalletViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/4.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TrustCore
import TrustKeystore
import MBProgressHUD

class CreateWalletViewController: UIViewController {

    @IBOutlet weak var tip3Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var repasswordTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var addressTipLabel: UILabel!
    @IBOutlet weak var accountAddressTitleLabel: UILabel!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var nameTextField: DottedLineTextField!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var copyPasswordButton: UIButton!
    @IBOutlet weak var copyAddressButton: UIButton!
    @IBOutlet var checkButtons: [UIButton]!
    
    var address: Variable<String> = Variable("")
    var password: Variable<String> = Variable("")
    var repassword: Variable<String> = Variable("")
    var name: Variable<String> = Variable("")
    
    var account: TrustKeystore.Account?
    var coordinator: WalletCoordinator?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton.isEnabled = false
        configureUI()
        
        let password = PasswordGenerator.generateRandom()
        displayLoading(text: "正在创建钱包", animated: true)
        WalletHelper.createInstantWallet(password: password) { (result) in
            self.hideLoading()
            switch result {
                
            case .success(let account):
                print(account.address)
                var account = account
                let string = String(base58CheckEncoding: account.address.data)
                self.address.value = string
            
                self.export(account: account)
                self.account = account
            case .failure(let error):
                print("创建失败")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        createButton.setBackgroundColor(UIColor.normalBackgroundColor, forState: .normal)
        createButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        createButton.setTitle(R.string.tron.createCreateButtonTitle(), for: .normal)
        copyAddressButton.setTitle(R.string.tron.createCopyButtonTitle(), for: .normal)
        copyPasswordButton.setTitle(R.string.tron.createCopyButtonTitle(), for: .normal)
        pasteButton.setTitle(R.string.tron.createPasteButtonTitle(), for: .normal)
        
        tip1Label.text = R.string.tron.createCheckboxTip1LabelTitle()
        tip2Label.text = R.string.tron.createCheckboxTip2LabelTitle()
        tip3Label.text = R.string.tron.createCheckboxTip3LabelTitle()
        
        accountAddressTitleLabel.text = R.string.tron.createAddressLabelTitle()
        addressTipLabel.text = R.string.tron.createAddressTipLabelTitle()
        passwordTitleLabel.text = R.string.tron.createPasswordLabelTitle()
        repasswordTitleLabel.text = R.string.tron.createRepasswordLabelTitle()
        
        for button in checkButtons {
            (button.rx.tap)
                .subscribe(onNext: { (_) in
                    button.isSelected = !button.isSelected
                })
            .disposed(by: disposeBag)
        }
        pasteButton.addTarget(self, action: #selector(pasteButtonClick), for: .touchUpInside)
        
        Observable.merge([(copyAddressButton.rx.tap).map({[weak self] (_) -> String? in
            return self?.accountTextField.text
        }),(copyPasswordButton.rx.tap).map({[weak self] (_) -> String? in
            return self?.passwordTextField.text
        })])
            .subscribe(onNext: { (text) in
                UIPasteboard.general.string = text
                
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = .text
                hud.label.text = R.string.tron.hudCopysuccess()
                hud.hide(animated: true, afterDelay: 1.5)
            })
        .disposed(by: disposeBag)
        
        
        
        address.asObservable().bind(to: accountTextField.rx.text).disposed(by: disposeBag)
        password.asObservable().bind(to: passwordTextField.rx.text).disposed(by: disposeBag)
        repassword.asObservable().bind(to: repasswordTextField.rx.text).disposed(by: disposeBag)
        name.asObservable().bind(to: nameTextField.rx.text).disposed(by: disposeBag)
        (nameTextField.rx.text).orEmpty
            .subscribe(onNext: {[weak self] (text) in
                self?.name.value = text
            })
        .disposed(by: disposeBag)
        
        Observable.combineLatest(
            name.asObservable().map{ $0.count > 0 },
            address.asObservable().map{ $0.count > 0 },
            password.asObservable().map{ $0.count > 0 },
            repassword.asObservable().map{ $0.count > 0 },
            (checkButtons[0].rx.tap).map { return self.checkButtons[0].isSelected },
            (checkButtons[1].rx.tap).map { return self.checkButtons[1].isSelected },
            (checkButtons[2].rx.tap).map { return self.checkButtons[2].isSelected }) { (a,b,c,d,e,f,g ) -> Bool in
                return a && b && c && d && e && f && g
        }.bind(to: createButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        createButton.addTarget(self, action: #selector(createButtonClick), for: .touchUpInside)
    }
    
    func export(account: TrustKeystore.Account) {
        let result = EtherKeystore.shared.exportPrivateKey(account: account)
        switch result {
        case .success(let data):
            let string = data.hexString
            self.password.value = string
            print(string)
        default:
            break
        }
    }

    @objc func pasteButtonClick() {
        repassword.value = UIPasteboard.general.string ?? ""
        
    }
    
    @objc func createButtonClick() {
        if let account = self.account {
            do {
                try EtherKeystore.shared.saveAccount(account)
                UserDefaults.standard.set(name.value, forKey: account.address.data.addressString)
                self.coordinator?.pushBackup(for: account)
                self.coordinator?.delegate = self
                
            } catch {
                HUD.showError(error: "Creat wallet failed")
            }
        }
    }
    
    @IBAction func showColdWalletInfo(_ sender: Any) {
        
        let path = Bundle.main.bundlePath
        let basePath = "\(path)/html/whatiscoldwallet.html"
        let url = URL(fileURLWithPath: basePath, isDirectory: true)
        BrowserHelper.show(url: url)
    }
    
    func showHomePage() {
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = R.storyboard.main.instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}

extension CreateWalletViewController: BackupViewControllerDelegate {
    func didPressBackup(account: Account, in viewController: BackupViewController) {
        
    }
}

extension CreateWalletViewController: WalletCoordinatorDelegate {
    func didFinish(with account: Wallet, in coordinator: WalletCoordinator) {
        ServiceHelper.shared.reset(wallet: account)
        self.showHomePage()
    }
    
    func didCancel(in coordinator: WalletCoordinator) {
        self.showHomePage()
    }
}
