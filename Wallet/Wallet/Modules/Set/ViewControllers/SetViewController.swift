
//
//  SetViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/14.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class SetViewController: UIViewController, Coordinator {
    var coordinators: [Coordinator] = []
    private let helpUsCoordinator = HelpUsCoordinator()
    private var lock = Lock()
    var isPasscodeEnabled: Bool {
        return lock.isPasscodeSet()
    }
    @IBOutlet weak var tableView: UITableView!
    var settingsCoordinator: SettingsCoordinator? = nil

    @IBOutlet weak var versionLabel: UILabel!
    let disposeBag = DisposeBag()
    
    var datas: [[SettingType]] = [[.wallets, .nodelist],[.password, .walletHelp], [.share]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        self.tableView.backgroundColor = UIColor.backgroundColor
        title = R.string.tron.settingNavTitle()
        //配置tableView
        tableView.register(R.nib.setTableViewCell)
        tableView.register(R.nib.setSwitchTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.lineColor
        
        versionLabel.text = R.string.tron.settingVersionTitle() + AppInfo.versionNumber
        
        ServiceHelper.shared.nodeChange.asObservable()
            .subscribe(onNext: {[weak self] () in
                self?.tableView.reloadData()
            })
        .disposed(by: disposeBag)
    }
    
    func setPasscode(completion: ((Bool) -> Void)? = .none) {
        let coordinator = LockCreatePasscodeCoordinator(
            model: LockCreatePasscodeViewModel()
        )
        coordinator.delegate = self
        coordinator.start()
        coordinator.lockViewController.willFinishWithResult = { [weak self] result in
            completion?(result)
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        addCoordinator(coordinator)
        navigationController?.present(coordinator.navigationController, animated: true, completion: nil)
    }
    
    @objc func showFirstTab() {
        self.tabBarController?.selectedIndex = 0
    }
}

extension SetViewController: LockCreatePasscodeCoordinatorDelegate {
    func didCancel(in coordinator: LockCreatePasscodeCoordinator) {
        coordinator.lockViewController.willFinishWithResult?(false)
        navigationController?.dismiss(animated: true, completion: nil)
        removeCoordinator(coordinator)
        self.tableView.reloadData()
    }

}

extension SetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.setTableViewCell.identifier) as! SetTableViewCell
        let type = datas[indexPath.section][indexPath.row]
        switch type {
        case .wallets:
            cell.detailLabel.text = ServiceHelper.shared.account.value?.address.addressString
        case .nodelist:
            cell.detailLabel.text = UserDefaults.Set.string(forKey: .fullnode)
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.setSwitchTableViewCell.identifier) as! SetSwitchTableViewCell
            cell.titleLabel.text = type.settingTitle
            cell.iconImageView?.image = type.iconImage
            cell.controlSwitch.isOn = self.isPasscodeEnabled
            cell.switchBlock = {[weak self] on in
                if on == true {
                    self?.setPasscode(completion: {[weak self] (success) in
                        self?.tableView.reloadData()
                    })
                } else {
                    self?.lock.deletePasscode()
                }
            }
            return cell
        default:
            break
        }
        cell.titleLabel.text = type.settingTitle
        cell.iconImageView?.image = type.iconImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = datas[indexPath.section][indexPath.row]
        switch type {
        case .wallets:
            let vc = R.storyboard.set.walletListViewController()!
            vc.accountCoordinator = self.settingsCoordinator?.accountsCoordinator
            CurrentControllerHelper.pushViewController(viewController: vc)
            vc.changeWalletBlock = {
                self.perform(#selector(self.showFirstTab), with: nil, afterDelay: 0.35)
            }
        case .share:
            self.helpUsCoordinator.presentSharing(in: self, from: self.view)
        case .walletHelp, .nodelist:
            type.open()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        }
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            let bottomLine = LineView()
            view.addSubview(bottomLine)
            bottomLine.snp.makeConstraints { (make) in
                make.right.bottom.equalTo(view)
                make.left.equalTo(view).offset(20)
                make.height.equalTo(0.5)
            }
            return view
        }
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = R.string.tron.settingSecionPasswordTitle()
        if section == 2 {
            label.text = R.string.tron.settingSecionShareTitle()
        }
        label.textColor = UIColor.colorWithHex(hex: "#85888D")
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(20)
        }

        let topLine = LineView()
        view.addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.right.top.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(0.5)
        }
        
        let bottomLine = LineView()
        view.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(0.5)
        }
        
        return view
    }
}

enum SettingType {
    //Wallets
    case wallets
    case nodelist
    case share
    case password
    case walletHelp
    
    var iconImage: UIImage? {
        switch self {
            
        case .wallets:
            return R.image.icon_Wallets()
        case .nodelist:
            return R.image.icon_set_node()
        case .share:
            return R.image.icon_set_share()
        case .password:
            return R.image.icon_set_password()
        case .walletHelp:
            return R.image.icon_cold()
        }
    }
    var settingTitle: String {
        switch self {
        case .wallets:
            return R.string.tron.settingWalletsTitle()
        case .nodelist:
            return R.string.tron.settingNodeTitle()
        case .share:
            return R.string.tron.settingShareTitle()
        case .password:
            return R.string.tron.settingPasswordTouchIDTitle()
        case .walletHelp:
            return R.string.tron.settingColdwalletTitle()
        }
    }
    
    func open() {
        switch self {

        case .wallets:
            let vc = R.storyboard.set.walletListViewController()!
            CurrentControllerHelper.pushViewController(viewController: vc)
        case .nodelist:
            let vc = R.storyboard.set.inputNodeViewController()!
            CurrentControllerHelper.pushViewController(viewController: vc)
        case .walletHelp:
            let url = ServiceHelper.shared.walletMode.value.url
            BrowserHelper.show(url: url)
        default:
            break
        }
    }
}

