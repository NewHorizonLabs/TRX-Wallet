//
//  BaseNavigationViewController.swift
//  SoloFitness
//
//  Created by Maynard on 2017/5/2.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import UIKit

typealias popCallBack = () -> (Void)
typealias pushCallBack = () -> (Void)

extension UIViewController {
    @objc var hideNavigationBar: Bool { return false }
}

class BaseNavigationViewController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var pop = {}
    var push = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.delegate = self
            delegate = self
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        if let lastVC = viewControllers.last {
            lastVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        interactivePopGestureRecognizer?.isEnabled = true
        push()
//        super.pushViewController(viewController, animated: true)
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        interactivePopGestureRecognizer?.delegate = self
        pop()
        return super.popViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count <= 1 {
            interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let value = viewController.hideNavigationBar
        navigationController.setNavigationBarHidden(value, animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}


