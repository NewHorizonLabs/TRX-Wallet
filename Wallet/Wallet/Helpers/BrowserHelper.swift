//
//  BrowserHelper.swift
//  KuTing
//
//  Created by Maynard on 2018/3/23.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit

class BrowserHelper: NSObject {
    class func show(url: URL) {
        let browserVC = R.storyboard.browser.browserViewController()!
        browserVC.url = url
        CurrentControllerHelper.pushViewController(viewController: browserVC)
    }
}
