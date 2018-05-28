//
//  DateButton.swift
//  Wallet
//
//  Created by Maynard on 2018/5/14.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DateButton: UIButton {

    var pickerView: UIDatePicker = UIDatePicker()
    let disposeBag = DisposeBag()
    var date: Variable<Date?> = Variable(nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        date.asObservable()
            .map{ return $0?.formatterString ?? "" }
        .bind(to: self.rx.title())
        .disposed(by: disposeBag)
    }
    
    @objc func buttonClick() {
        let vc = KTPickerViewController()
        vc.sureClick.map({[weak self] (_) -> Date in
            return (self?.pickerView.date) ?? Date()
        })
            .asObservable()
            .bind(to: self.date)
            .disposed(by: disposeBag)
        vc.show(view: pickerView)
    }

}
