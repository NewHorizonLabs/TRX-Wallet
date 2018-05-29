//
//  FrozenView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/29.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FrozenView: UIView, XibLoadable, Popable {

    @IBOutlet weak var frozenButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfigure()
    }
    
    func baseConfigure() {
        (numberTextField.rx.text).orEmpty.map{ return $0.count > 0 }
        .asObservable()
        .bind(to: frozenButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        (frozenButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.frozenButtonClick()
            })
            .disposed(by: disposeBag)
    }
    
    func frozenButtonClick() {
        guard let numberText = numberTextField.text, let number = Int64(numberText), let account = ServiceHelper.shared.account.value else {
            return
        }
        let contract = FreezeBalanceContract()
        contract.frozenBalance = number
        contract.ownerAddress = account.address
        contract.frozenDuration = 3
        ServiceHelper.shared.service.freezeBalance(withRequest: contract) { (transaction, error) in
            if let action = transaction {
                ServiceHelper.shared.broadcastTransaction(action, completion: { (response, error) in
                    if let response = response {
                        let result = response.result
                        let message = String.init(data: response.message, encoding: .utf8)
                        print(response)
                        if result {
                            self.popDismiss()
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
