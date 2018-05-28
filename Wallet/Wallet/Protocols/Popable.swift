//
//  Popable.swift
//  SoloFitness
//
//  Created by Maynard on 2017/5/9.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxGesture
import pop

protocol Popable {
    var autoDismiss: Bool {get}
    func popShow()
    func popDismiss()
}

extension Popable where Self: UIView {
    var autoDismiss: Bool {
        return false
    }
    
    func popShow() {
        
        let vc = PopViewController()
        vc.show(view: self)
        
    }
    
    func popDismiss() {
        if let currentVC = CurrentControllerHelper.currentViewController() as? PopViewController {
            currentVC.dismissView()
        } else {
            UIView.animate(withDuration: 0.35, animations: {
                self.superview?.alpha = 0.0
            }) { (finished) in
                self.superview?.removeFromSuperview()
            }
        }
        
    }

}
