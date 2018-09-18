//
//  KTPickerViewController.swift
//  New Horizon Labs
//
//  Created by  on 2018/4/1.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxSwift

class KTPickerViewController: UIViewController {
    
    var sureClick:PublishSubject<Void> = PublishSubject<Void>()
    var cancleClick:PublishSubject<Void> = PublishSubject<Void>()
    
    var previousWindow: UIWindow?
    var alertWindow: UIWindow?
    
    var containerViewHeight: CGFloat {
        return 280
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    @objc func sureButtonClick() {
        self.dismissView()
        sureClick.onNext(())
    }
    
    func configureUI() {
        
        let sureButton = UIButton(type: .custom)
        sureButton.setImage(R.image.alert_sure(), for: .normal)
        sureButton.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        containerView.addSubview(sureButton)
        
        let cancleButton = UIButton(type: .custom)
        cancleButton.setImage(R.image.alert_cancle(), for: .normal)
        cancleButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        containerView.addSubview(cancleButton)
        
        cancleButton.snp.makeConstraints({ (make) in
            make.left.equalTo(containerView)
            make.top.equalTo(containerView).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(40)
        })
        
        sureButton.snp.makeConstraints({ (make) in
            make.right.equalTo(containerView)
            make.top.equalTo(containerView).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(40)
        })
        
        containerView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: containerViewHeight)
        view.addSubview(containerView)
        
    }
    
    func show(view: UIView) {
        let bounds = UIScreen.main.bounds
        alertWindow = UIWindow(frame: bounds)
        previousWindow = UIApplication.shared.keyWindow
        self.alertWindow?.rootViewController = self
        self.alertWindow?.makeKeyAndVisible()
        self.view.backgroundColor = UIColor.maskBackgroundColor
        self.view.alpha = 0.0
        containerView.insertSubview(view, at: 0)
        view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(containerView)
            make.top.equalTo(containerView).offset(40)
        }
        UIView.animate(withDuration: 0.35) {
            self.containerView.frame = CGRect(x: 0, y: kScreenHeight - self.containerViewHeight, width: kScreenWidth, height: self.containerViewHeight)
            self.view.alpha = 1.0
        }
    }
    
    @objc func dismissView() {
        UIView.animate(withDuration: 0.35, animations: {
            self.containerView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: self.containerViewHeight)
            self.view.alpha = 0.5
        }) { (finished) in
            self.alertWindow?.removeFromSuperview()
            self.previousWindow?.makeKeyAndVisible()
            
        }
    }

}
