//
//  ColdTransactionView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/31.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ColdTransactionView: UIView, XibLoadable, Popable {

    @IBOutlet weak var closeButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        (closeButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.popDismiss()
            })
            .disposed(by: disposeBag)
    }

}
