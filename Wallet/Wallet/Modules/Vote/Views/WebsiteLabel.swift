//
//  WebsiteLabel.swift
//  TRXWallet
//
//  Created by Maynard on 2018/7/2.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxGesture
import RxSwift

class WebsiteLabel: UILabel {
    
    var url: URL?
    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        self.rx.tapGesture()
        .when(.recognized)
            .subscribe(onNext: {[weak self] (tap) in
                self?.showURL()
            })
        .disposed(by: disposeBag)
    }
    
    func showURL() {
        guard let url = url else {
            return
        }
        BrowserHelper.show(url: url)
    }

}
