// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    @discardableResult
    static func openFormSheet(
        for controller: UIViewController,
        in navigationController: NavigationController,
        barItem: UIBarButtonItem
        ) -> UIViewController {
        if UIDevice.current.userInterfaceIdiom == .pad {
            controller.navigationItem.leftBarButtonItem = barItem
            let nav = NavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .formSheet
            navigationController.present(nav, animated: true, completion: nil)
        } else {
            navigationController.pushViewController(controller, animated: true)
        }
        return controller
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        var preferredStyle: UIStatusBarStyle
        if topViewController is BalanceViewController {
            preferredStyle = .lightContent
        } else {
            preferredStyle = .default
        }
        return preferredStyle
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        if let lastVC = viewControllers.last {
            lastVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        interactivePopGestureRecognizer?.isEnabled = true
        //        super.pushViewController(viewController, animated: true)
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        interactivePopGestureRecognizer?.delegate = self
        self.viewControllers.last?.hidesBottomBarWhenPushed = false
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        self.viewControllers.last?.hidesBottomBarWhenPushed = false
        return super.popToRootViewController(animated: animated)
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
