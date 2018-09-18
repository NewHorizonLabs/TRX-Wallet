//
//  FrozenView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/29.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FrozenView: UIView, XibLoadable, Popable {
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var frozenButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberTipLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var comfirmTipLabel: UILabel!
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfigure()
    }
    
    func configureUI() {
        titleLabel.text = R.string.tron.balanceFreezePopViewTitle()
        amountLabel.text = R.string.tron.balanceFreezePopViewAmountLabelTitle()
        numberTipLabel.text = R.string.tron.tokenPopViewInputTitle()
        frozenButton.setTitle(R.string.tron.balanceFreezePopViewFreezeButtonTitle(), for: .normal)
        comfirmTipLabel.text = R.string.tron.balanceFreezePopViewConfirmtipLabelTitle()
        frozenButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        frozenButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
    }
    
    func baseConfigure() {
        configureUI()
        frozenButton.isEnabled = false
        frozenButton.setBackgroundColor(UIColor.normalBackgroundColor, forState: .normal)
        frozenButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        
        (frozenButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.frozenButtonClick()
            })
            .disposed(by: disposeBag)
        
        (closeButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.popDismiss()
            })
            .disposed(by: disposeBag)
        
        let inputSignal = (numberTextField.rx.text).orEmpty.asObservable()
        inputSignal
            .map { return $0.count > 0 }
            .bind(to: numberTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        let checkSignal = (checkButton.rx.tap).asObservable().map { (_) -> Bool in
            self.checkButton.isSelected = !self.checkButton.isSelected
            return self.checkButton.isSelected
        }
        
        Observable.combineLatest(checkSignal, inputSignal) { (checked, text) -> Bool in
            return self.checkButton.isSelected && text.count > 0
        }.bind(to: frozenButton.rx.isEnabled)
        .disposed(by: disposeBag)
        numberTextField.becomeFirstResponder()
        
        
    }
    
    func frozenButtonClick() {
        guard let numberText = numberTextField.text, let number = Int64(numberText), let account = ServiceHelper.shared.account.value else {
            return
        }
        let freezeContract = FreezeBalanceContract()
        freezeContract.ownerAddress = account.address
        freezeContract.frozenBalance = number * 1000000
        freezeContract.frozenDuration = 3
        ServiceHelper.shared.service.freezeBalance(withRequest: freezeContract) { (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (response, error) in
                    if let response = response {
                        let result = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        print(response)
                        if result {
                            self.popDismiss()
                            ServiceHelper.shared.getAccount()
                            HUD.showText(text: R.string.tron.hudSuccess())
                        } else {
                            HUD.showError(error: response.errorMessage)
                        }
                    } else if let error = error {
                        HUD.showError(error: error.localizedDescription)
                    }
                })
            } else if let error = error {
                HUD.showError(error: error.localizedDescription)
            }
        }
    }
}
