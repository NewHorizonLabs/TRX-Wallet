//
//  CurrentViewControllerHelper.swift
//  SoloFitness
//
//  Created by Maynard on 2017/4/20.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import UIKit

//当前控制器相关方法
class CurrentControllerHelper: NSObject {
    class func currentViewController() -> UIViewController {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            if rootVC is UITabBarController {
                let tabBarVC = rootVC as! UITabBarController
                
                let selectedVC = tabBarVC.selectedViewController
                if selectedVC is UINavigationController {
                    let navigationVC = selectedVC as! UINavigationController
                    if let lastVC = navigationVC.viewControllers.last {
                        return CurrentControllerHelper.presentingViewController(viewController: lastVC)
                    }
                }
            }
            else if rootVC is UINavigationController {
                let navigationVC = rootVC as! UINavigationController
                if let lastVC = navigationVC.viewControllers.last {
                    return CurrentControllerHelper.presentingViewController(viewController: lastVC)
                }
            }
            return CurrentControllerHelper.presentingViewController(viewController: rootVC)
        }
        return UIViewController()
    }
    
    private class func presentingViewController(viewController: UIViewController) -> UIViewController {
        if viewController is UINavigationController {
            let navigationVC = viewController as! UINavigationController
            if let lastVC = navigationVC.viewControllers.last {
                if let pVC = lastVC.presentedViewController {
                    return CurrentControllerHelper.presentingViewController(viewController: pVC)
                }
                else {
                    return lastVC
                }
            }
            
        }
        else {
            if let pVC = viewController.presentedViewController {
                return CurrentControllerHelper.presentingViewController(viewController: pVC)
            }
            else {
                return viewController
            }
        }
        return viewController
        
    }
    
    @discardableResult
    class func presentViewController(viewController: UIViewController) -> Bool {
        let currentViewController = self.currentViewController()
        currentViewController.present(viewController, animated: true, completion: nil)
        return true
    }
    
    @discardableResult
    class func pushViewController(viewController: UIViewController) -> Bool {
        let currentViewController = self.currentViewController()
        guard currentViewController.navigationController != nil else { return false }
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
        return true
    }
}
