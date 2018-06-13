//
//  CreateTokenViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/14.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateTokenViewController: UIViewController {


    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var tokenNameTitleLabel: UILabel!
    
    @IBOutlet weak var totalSupplyTitleLabel: UILabel!
    
    @IBOutlet weak var tokenAbbreviationTitleLabel: UILabel!
    @IBOutlet weak var tokenAbbreviationTextFiled: UITextField!
    @IBOutlet weak var frozenAmountTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var frozenDaysTitleLabel: UILabel!
    
    @IBOutlet weak var urlTitleLabel: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var trxNumTitleLabel: UILabel!
    
    @IBOutlet weak var confirmTipTitleLabel: UILabel!
    @IBOutlet weak var endTimeTitleLabel: UILabel!
    @IBOutlet weak var startTimeTitleLabel: UILabel!
    @IBOutlet weak var tokenNumTitleLabel: UILabel!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var totalTextFiled: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var urlTipLabel: UILabel!
    @IBOutlet weak var descriptionTipLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var nameTipLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var trxTextField: UITextField!
    
    @IBOutlet weak var changeTipLabel: UILabel!
    @IBOutlet weak var trxTipLabel: UILabel!
    
    @IBOutlet weak var tokenNumTipLabel: UILabel!
    @IBOutlet weak var tokenNumberTextField: UITextField!
    
    @IBOutlet weak var freezeNumberTextField: UITextField!
    @IBOutlet weak var freezeNumberTipLabel: UILabel!
    
    @IBOutlet weak var freezeDaysTipLabel: UILabel!
    
    @IBOutlet weak var freezeDaysTextField: UITextField!
    
    @IBOutlet weak var endTimeTipLabel: UILabel!
    @IBOutlet weak var startTimeTipLabel: UILabel!
    @IBOutlet weak var endDateButton: DateButton!
    @IBOutlet weak var startDateButton: DateButton!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var name: Variable<String> = Variable("")
    var abbreviation: Variable<String> = Variable("")
    var total: Variable<String> = Variable("")
    var descriptionString: Variable<String> = Variable("")
    var url: Variable<String> = Variable("")
    var trxString: Variable<String> = Variable("")
    var tokenNumString: Variable<String> = Variable("")
    
    var startTime: Variable<String> = Variable("")
    var endTime: Variable<String> = Variable("")
    
    var freezeNumber: Variable<Int64> = Variable(0)
    var freezeDays: Variable<Int64> = Variable(0)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMyIssue()
    }
    
    func getMyIssue() {
        guard let account = ServiceHelper.shared.account.value else {
            return
        }
        self.displayLoading()
        ServiceHelper.shared.service.getAssetIssueByAccount(withRequest: account) { (list, error) in
            if let list = list?.assetIssueArray, list.count > 0 {
                self.scrollView.isHidden = true
            } else {
                self.scrollView.isHidden = false
            }
            self.hideLoading()
        }
    }
    
    func configureUI() {
        title = R.string.tron.issueTokenNavTitle()
        detailTitleLabel.text = R.string.tron.issueTokenDetailsLabelTitle()
        tokenNameTitleLabel.text = R.string.tron.issueTokenIssueatokenLabelTitle()
        totalSupplyTitleLabel.text = R.string.tron.issueTokenTotalsupplyLabelTitle()
        frozenAmountTitleLabel.text = R.string.tron.issueTokenFrozenamountLabelTitle()
        frozenDaysTitleLabel.text = R.string.tron.issueTokenFrozendaysLabelTitle()
        descriptionTipLabel.text = R.string.tron.issueTokenDescriptionLabelTitle()
        urlTitleLabel.text = R.string.tron.issueTokenUrlLabelTitle()
        tipLabel.text = R.string.tron.issueTokenTipLabelTitle()
        trxNumTitleLabel.text = R.string.tron.issueTokenTrxamountLabelTitle()
        tokenNumTitleLabel.text = R.string.tron.issueTokenTokenamountLabelTitle()
        startTimeTitleLabel.text = R.string.tron.issueTokenStarttimeLabelTitle()
        endTimeTitleLabel.text = R.string.tron.issueTokenEndtimeLabelTitle()
        confirmTipTitleLabel.text = R.string.tron.issueTokenConfirmtipCheckboxTitle()
        createButton.setTitle(R.string.tron.issueTokenIssueButtonTitle(), for: .normal)
        
        createButton.isEnabled = false
        createButton.setBackgroundColor(UIColor.normalBackgroundColor, forState: .normal)
        createButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        
        (nameTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: nameTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (tokenAbbreviationTextFiled.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: tokenAbbreviationTitleLabel.rx.isHidden).disposed(by: disposeBag)
        
        (totalTextFiled.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: totalTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (descriptionTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: descriptionTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (urlTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: urlTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (trxTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: trxTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (tokenNumberTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: tokenNumTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (freezeNumberTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: freezeNumberTipLabel.rx.isHidden).disposed(by: disposeBag)
        (freezeDaysTextField.rx.text).orEmpty.asObservable().map { return $0.count > 0 }.bind(to: freezeDaysTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        (nameTextField.rx.text).orEmpty.bind(to: name).disposed(by: disposeBag)
        (tokenAbbreviationTextFiled.rx.text).orEmpty.bind(to: abbreviation).disposed(by: disposeBag)
        (totalTextFiled.rx.text).orEmpty.bind(to: total).disposed(by: disposeBag)
        (descriptionTextField.rx.text).orEmpty.bind(to: descriptionString).disposed(by: disposeBag)
        (urlTextField.rx.text).orEmpty.bind(to: url).disposed(by: disposeBag)
        (trxTextField.rx.text).orEmpty.bind(to: trxString).disposed(by: disposeBag)
        (tokenNumberTextField.rx.text).orEmpty.bind(to: tokenNumString).disposed(by: disposeBag)
        
        (freezeNumberTextField.rx.text).orEmpty.map{ return Int64($0) ?? 0 }.bind(to: freezeNumber).disposed(by: disposeBag)
        (freezeDaysTextField.rx.text).orEmpty.map{ return Int64($0) ?? 0 }.bind(to: freezeDays).disposed(by: disposeBag)
        
        startDateButton.date.asObservable().map { return $0 != nil }.bind(to: startTimeTipLabel.rx.isHidden).disposed(by: disposeBag)
        endDateButton.date.asObservable().map { return $0 != nil }.bind(to: endTimeTipLabel.rx.isHidden).disposed(by: disposeBag)
        let signal = (checkButton.rx.tap).asObservable().map { (_) -> Bool in
            self.checkButton.isSelected = !self.checkButton.isSelected
            return self.checkButton.isSelected
        }
        
        let combine = Observable.combineLatest(
            name.asObservable().map{ $0.count > 0 },
            total.asObservable().map{ $0.count > 0 },
            descriptionString.asObservable().map{ $0.count > 0 },
            url.asObservable().map{ $0.count > 0 },
            trxString.asObservable().map{ $0.count > 0 },
            tokenNumString.asObservable().map{ $0.count > 0 },
            startDateButton.date.asObservable().map { return $0 != nil },
            endDateButton.date.asObservable().map { return $0 != nil }
            ) { (a,b,c,d,e,f,g,h ) -> Bool in
                return a && b && c && d && e && f && g && h
            }
        
        Observable.combineLatest(signal, combine, abbreviation.asObservable().map{ $0.count > 0 }) { (a, b, c) -> Bool in
            
                return a && b && c
            }.bind(to: createButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(trxString.asObservable(), tokenNumString.asObservable()) { (trx, token) -> String in
            if let trxNum = Double(trx), let tokenNum = Double(token) {
                return "1 Token = \(trxNum/tokenNum) TRX"
            }
            return ""
        }.bind(to: changeTipLabel.rx.text)
        .disposed(by: disposeBag)
        
    
        
        createButton.addTarget(self, action: #selector(createButtonClick), for: .touchUpInside)
        
        startDateButton.pickerView.minimumDate = Date().addingTimeInterval(60 * 60)
        endDateButton.pickerView.minimumDate = Date().addingTimeInterval(2 * 60 * 60)
    }

    func validName(name: String) -> Bool {
        let pre = "^[A-Za-z]+$";
        let namePre = NSPredicate(format: "SELF MATCHES %@", pre)
        return namePre.evaluate(with:name)
    }

    @objc func createButtonClick() {
        guard validName(name: name.value) else {
            HUD.showText(text: "Name may only contain a-Z characters")
            nameTextField.becomeFirstResponder()
            return
        }
        guard abbreviation.value.count <= 5 else {
            HUD.showText(text: "Abbreviation may not be longer then 5 characters")
            tokenAbbreviationTextFiled.becomeFirstResponder()
            return
        }
        
        guard let balance = Int64(ServiceHelper.shared.balance), balance > 1024 else {
            HUD.showText(text: "Your TRX less than 1024")
            return
        }
        guard let account = ServiceHelper.shared.account.value, let total = Int64(total.value), let trxNum = Int32(trxString.value), let num = Int32(tokenNumString.value), let startDate = startDateButton.date.value, let endDate = endDateButton.date.value else {
            return
        }
        let contract = AssetIssueContract()
        contract.ownerAddress = account.address
        contract.name = name.value.data(using: .utf8)
        contract.abbr = abbreviation.value.data(using: .utf8)
        let startTime = startDate.timeIntervalSince1970 * 1000
        contract.startTime = Int64(startTime)
        contract.endTime = Int64(endDate.timeIntervalSince1970 * 1000)
        contract.totalSupply = total
        contract.trxNum = trxNum * 1000000
        contract.num = num
        contract.voteScore = 1
        contract.url = url.value.data(using: .utf8)
        contract.description_p = descriptionString.value.data(using: .utf8)
        let freeze = AssetIssueContract_FrozenSupply()
        freeze.frozenAmount = freezeNumber.value
        freeze.frozenDays = freezeDays.value
        contract.frozenSupplyArray = [freeze]
        contract.publicFreeAssetNetUsage = 0
        contract.publicFreeAssetNetLimit = 0
        contract.freeAssetNetLimit = 0
        self.displayLoading()
        
        ServiceHelper.shared.service.createAssetIssue(withRequest: contract) {[weak self] (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: {[weak self] (result, error) in
                    if let response = result {
                        let success = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        self?.hideLoading()
                        HUD.showText(text: R.string.tron.hudSuccess())
                        ServiceHelper.shared.tokenChange.onNext(())
                        if success { self?.navigationController?.popViewController(animated: true)
                        } else {
                            HUD.showError(error: response.errorMessage)
                        }
                    } else if let error = error {
                        HUD.showError(error: error.localizedDescription)
                    }
                    self?.hideLoading()
                })
            } else if let error = error {
                HUD.showError(error: error.localizedDescription)
                self?.hideLoading()
            }
        }
    }

}
