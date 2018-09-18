//
//  SelectButton.swift
//  New Horizon Labs
//
//  Created by  on 2018/3/26.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectButton: UIButton {
    let disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitleColor(UIColor.white, for: .selected)
        self.setTitleColor(UIColor.white, for: .normal)
        self.addObserver(self, forKeyPath: "selected", options: .new, context: nil)
        self.updateSelectedStatus()
    }
    
    func updateSelectedStatus() {
        if self.isSelected {
            self.backgroundColor = UIColor.mainNormalColor
        } else {
            self.backgroundColor = UIColor.lightTitleColor
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selected" {
            self.updateSelectedStatus()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "selected")
    }


}
