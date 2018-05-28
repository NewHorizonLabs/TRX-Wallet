//
//  PopViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/15.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import pop

class PopViewController: UIViewController {
    
    var previousWindow: UIWindow?
    var alertWindow: UIWindow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func show(view: UIView) {
        let bounds = UIScreen.main.bounds
        alertWindow = UIWindow(frame: bounds)
        previousWindow = UIApplication.shared.keyWindow
        self.alertWindow?.rootViewController = self
        self.alertWindow?.makeKeyAndVisible()
        self.view.backgroundColor = UIColor.maskBackgroundColor
        self.view.alpha = 0.0
        
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.centerX.centerY.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.88)
            make.height.equalTo(view.pheight)
        })
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)!
        scaleAnimation.fromValue = NSValue(cgSize: CGSize(width: 0.8, height: 0.8))
        scaleAnimation.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnimation.springBounciness = 20.0
        scaleAnimation.springSpeed = 15.0
        
        view.pop_add(scaleAnimation, forKey: "scale")
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 1.0
        })
    }
    
    @objc func dismissView() {
        UIView.animate(withDuration: 0.35, animations: {
            self.view.alpha = 0.0
        }) { (finished) in
            self.alertWindow?.removeFromSuperview()
            self.previousWindow?.makeKeyAndVisible()
        }
    }

}
