//  UIConfigure.swift
//  RayboWallet
//
//  Created by Maynard on 2017/4/21.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import UIKit
import Foundation

class UIConfigure {
    //配置tabbar 样式
    class func tabbar() {
        UITabBar.appearance().tintColor = UIColor.mainNormalColor
        UITabBar.appearance().backgroundColor = UIColor.white
        let tabbar = UITabBar.appearance()
        tabbar.barTintColor = UIColor.white
        tabbar.isTranslucent = false
    }
    
    //配置导航栏样式
    class func navgationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.mainNormalColor
        UINavigationBar.appearance().isTranslucent = false
        
        let image = R.image.ic_back()?.withRenderingMode(.alwaysOriginal)

        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().titleTextAttributes =  [NSAttributedStringKey.foregroundColor:UIColor.colorWithHex(hex: "#212837"), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes =  [NSAttributedStringKey.foregroundColor:UIColor.mainNormalColor]
        } else {
            // Fallback on earlier versions
        }
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-200, 0), for:UIBarMetrics.default)
    }
    
    //配置tableview 样式
    class func tableView() {
        let tableView = UITableView.appearance()
        tableView.separatorColor = UIColor.lineColor
        
        let tableViewCell = UITableViewCell.appearance()
        let view = UIView()
        view.backgroundColor = UIColor.tableViewCellSelectedColor
        tableViewCell.selectedBackgroundView = view
    }
    
    class func button() {
        let env = getenv("DYLD_INSERT_LIBRARIES")
        if env != nil {
            let alertVC = UIAlertController(title: "The device has been break prison", message: "It is dangerous run in this device", preferredStyle: .alert)
            let action = UIAlertAction(title: "I know", style: .cancel, handler: nil)
            alertVC.addAction(action)
            CurrentControllerHelper.currentViewController().show(alertVC, sender: nil)
        }
    }
    
}
