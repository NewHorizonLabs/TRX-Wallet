//
//  WalletListViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/14.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UITableView_FDTemplateLayoutCell
import TrustKeystore
import TrustCore
import RealmSwift

class WalletListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    var data: Variable<[Wallet]> = Variable(EtherKeystore.shared.wallets)
    var coordinator: BackupCoordinator?
    var accountCoordinator: AccountsCoordinator?
    var changeWalletBlock: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.tron.walletsNavTitle()
        tableView.register(R.nib.walletTableViewCell)
        self.view.backgroundColor = UIColor.backgroundColor
        self.tableView.backgroundColor = UIColor.backgroundColor
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.walletTableViewCell.identifier, cellType: WalletTableViewCell.self)) { index, model, cell in
            cell.configure(model: model)
            cell.backgroundColorType = index % 2 == 0 ? .blue : .red
            let address = model.address.data.addressString
            if let value = UserDefaults.standard.string(forKey: address) {
                cell.nameLabel.text = value
            } else {
                UserDefaults.standard.setValue("Wallet\(index + 1)", forKey: address)
                cell.nameLabel.text = "Wallet\(index + 1)"
            }
            cell.cellDelegate = self
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Wallet.self).subscribe(onNext: {[weak self] (model) in
            ServiceHelper.shared.reset(wallet: model)
//            self?.export(model: model)
            self?.navigationController?.popToRootViewController(animated: true)
            self?.changeWalletBlock?()
        }).disposed(by: disposeBag)
        addButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
    
        let config = Config.current
        let account = ServiceHelper.shared.currentWallet!
        let migration = MigrationInitializer(account: account, chainID: config.chainID)
        migration.perform()
        
        let sharedMigration = SharedMigrationInitializer()
        sharedMigration.perform()
        let realm = self.realm(for: migration.config)
        let sharedRealm = self.realm(for: sharedMigration.config)
        let tokensStorage = TokensDataStore(realm: realm, config: config)
        let balanceCoordinator =  TokensBalanceService()
        let viewModel = InCoordinatorViewModel(config: config)
        let trustNetwork = TrustNetwork(provider: TrustProviderFactory.makeProvider(), balanceService: balanceCoordinator, account: account, config: config)
        let balance =  BalanceCoordinator(account: account, config: config, storage: tokensStorage)
        let transactionsStorage = TransactionsStorage(
            realm: realm,
            account: account
        )
        let nonceProvider = GetNonceProvider(storage: transactionsStorage)
        let session = WalletSession(
            account: account,
            config: config,
            balanceCoordinator: balance,
            nonceProvider: nonceProvider
        )

        
        self.accountCoordinator = {
            let coordinator = AccountsCoordinator(
                navigationController: self.navigationController as! NavigationController,
                keystore: EtherKeystore.shared,
                session: session,
                balanceCoordinator: balanceCoordinator
            )
            coordinator.delegate = self
            return coordinator
        }()
    }
    
    
    private func realm(for config: Realm.Configuration) -> Realm {
        return try! Realm(configuration: config)
    }
    
    func reload() {
        let wallets = EtherKeystore.shared.wallets
        if wallets.count == 0{
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController = R.storyboard.login.instantiateInitialViewController()
                window.makeKeyAndVisible()
            }
        } else {
            data.value = EtherKeystore.shared.wallets
        }
    }
    
    func backupWallet(wallet: Wallet) {
        switch wallet.type {
        case .privateKey(let account):
            coordinator = BackupCoordinator(
                navigationController: self.navigationController as! NavigationController,
                keystore: EtherKeystore.shared,
                account: account
            )
            coordinator?.delegate = self
            coordinator?.start()
        default:
            break
        }
        
    }
    
    func exportPrivateKey(for account: Account) {
        let coordinator = ExportPrivateKeyCoordinator(
            keystore: EtherKeystore.shared,
            account: account
        )
        coordinator.delegate = self
        coordinator.start()
        self.coordinator?.addCoordinator(coordinator)
        navigationController?.present(coordinator.navigationController, animated: true, completion: nil)
        
    }
    
    func export(model: Wallet) {
        let account = EtherKeystore.shared.getAccount(for: model.address)
        let address = account?.address.data.addressString
        let result = EtherKeystore.shared.exportPrivateKey(account: account!)
        switch result {
        case .success(let data):
            let string = data.hexString
            print(string)
        default:
            break
        }
    }
    
    func showInfoSheet(for account: Wallet, sender: UIView) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.popoverPresentationController?.sourceView = sender
        controller.popoverPresentationController?.sourceRect = sender.centerRect
        
        switch account.type {
        case .privateKey(let account):
            let actionTitle = NSLocalizedString("wallets.backup.alertSheet.title", value: "Backup Keystore", comment: "The title of the backup button in the wallet's action sheet")
            let backupKeystoreAction = UIAlertAction(title: actionTitle, style: .default) { [unowned self] _ in
                let coordinator = BackupCoordinator(
                    navigationController: self.navigationController as! NavigationController,
                    keystore: EtherKeystore.shared,
                    account: account
                )
                coordinator.delegate = self
                coordinator.start()
                self.coordinator?.addCoordinator(coordinator)
            }
            let exportTitle = NSLocalizedString("wallets.export.alertSheet.title", value: "Export Private Key", comment: "The title of the export button in the wallet's action sheet")
            let exportPrivateKeyAction = UIAlertAction(title: exportTitle, style: .default) { [unowned self] _ in
                self.exportPrivateKey(for: account)
            }
            controller.addAction(backupKeystoreAction)
            controller.addAction(exportPrivateKeyAction)
        case .hd, .address:
            break
        }
        
        let copyAction = UIAlertAction(
            title: NSLocalizedString("Copy Address", value: "Copy Address", comment: ""),
            style: .default
        ) { _ in
            UIPasteboard.general.string = account.address.description
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", value: "Cancel", comment: ""), style: .cancel) { _ in }
        
        controller.addAction(copyAction)
        controller.addAction(cancelAction)
        navigationController?.present(controller, animated: true, completion: nil)
    }
    
    @objc func addButtonClick() {
        let vc = R.storyboard.login.instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }

}

extension WalletListViewController: ExportPrivateKeyCoordinatorDelegate {
    func didCancel(in coordinator: ExportPrivateKeyCoordinator) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


extension WalletListViewController: BackupCoordinatorDelegate {
    func didCancel(coordinator: BackupCoordinator) {
        
    }
    
    func didFinish(wallet: Wallet, in coordinator: BackupCoordinator) {
        
    }
}

extension WalletListViewController: AccountsCoordinatorDelegate {
    func didCancel(in coordinator: AccountsCoordinator) {
        
    }
    
    func didSelectAccount(account: Wallet, in coordinator: AccountsCoordinator) {
        
    }
    
    func didAddAccount(account: Wallet, in coordinator: AccountsCoordinator) {
        
    }
    
    func didDeleteAccount(account: Wallet, in coordinator: AccountsCoordinator) {
        
    }
    
    
}

extension WalletListViewController: WalletWalletTableViewCellDelegate {
    func confirmDelete(wallet: Wallet) {
        confirm(
            title: NSLocalizedString("accounts.confirm.delete.title", value: "Are you sure you would like to delete this wallet?", comment: ""),
            message: NSLocalizedString("accounts.confirm.delete.message", value: "Make sure you have backup of your wallet.", comment: ""),
            okTitle: NSLocalizedString("accounts.confirm.delete.okTitle", value: "Delete", comment: ""),
            okStyle: .destructive
        ) { [weak self] result in
            switch result {
            case .success:
                self?.delete(wallet: wallet)
            case .failure: break
            }
        }
    }
    
    func showInfoButtonClick(wallet: Wallet, view: UIView) {
        self.accountCoordinator?.showInfoSheet(for: wallet, sender: view)
    }
    
    func delete(wallet: Wallet) {
        navigationController?.displayLoading(text: NSLocalizedString("Deleting", value: "Deleting", comment: ""))
        ServiceHelper.shared.keystore.delete(wallet: wallet) { [weak self] result in
            guard let `self` = self else { return }
            self.navigationController?.hideLoading()
            switch result {
            case .success:
                self.reload()
            case .failure(let error):
                self.displayError(error: error)
            }
        }
    }
}
