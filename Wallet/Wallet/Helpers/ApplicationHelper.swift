//
//  ApplicationHelper.swift
//  Sports
//
//  Created by RayboWallet on 2017/4/18.
//  Copyright © 2017年 RayboWallet. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

final class ApplicationHelper {
    //保持屏幕常亮,true:常亮，false:不常亮
    class func keepScreen(active: Bool) {
        UIApplication.shared.isIdleTimerDisabled = !active
    }
    
    class func setStatusBar(style: UIStatusBarStyle) {
        UIApplication.shared.setStatusBarStyle(style, animated: false)
    }
    
    class func setStatusBar(hidden: Bool) {
        UIApplication.shared.setStatusBarHidden(hidden, with: .none)
    }
    
    //去评分页
    //    class func starApplication() {
    //        UIApplication.shared.open(URL(string: "https://itunes.apple.com/cn/app/art-collage-photo-grid-pic-editor-layout-maker/id1196171334?mt=8")!, options: [:], completionHandler: nil)
    //    }
    
    
    class func buildCode() -> Int {
        guard let cfbuildString = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
            let cfbuildNumber: Int = Int(cfbuildString) else {
                return 0
        }
        return cfbuildNumber
    }
    
    // MARK:- 检查是否需要提示用户版本更新
    static  func checkShouldAlertUserUpgradeApp() {
        
        guard let cfbuildString = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
            let cfbuildNumber: Int = Int(cfbuildString),
            let forNum: Int = RemoteConfigureHelper.numberValue(.forceVersion)?.intValue,
            let forceButtonTitle = RemoteConfigureHelper.stringValue(.forceVersionButtonDescription),
            let forceContent = RemoteConfigureHelper.stringValue(.forceVersionDescription),
            let forceURL = RemoteConfigureHelper.stringValue(.forceVersionDownloadURL),
            let optionNum: Int = RemoteConfigureHelper.numberValue(.optionalVersion)?.intValue,
            let optionContent = RemoteConfigureHelper.stringValue(.optionalVersionDescription),
            let optionURL = RemoteConfigureHelper.stringValue(.optionalVersionDownloadURL),
            let optionalButtonTitle = RemoteConfigureHelper.stringValue(.optionalVersionButtonDescription)
            else {
                return
        }
        
        if cfbuildNumber < forNum{
            alertUpdate(isForce: true, buttonTitle: forceButtonTitle, content: forceContent, url: forceURL)
        }else if cfbuildNumber >= forNum && cfbuildNumber < optionNum{
            
            if optionNum > UserDefaults.Appalication.integer(forKey: .appOptionVersionNumber) {
                alertUpdate(isForce: false, buttonTitle:optionalButtonTitle, content: optionContent, url: optionURL)
            }
            
            UserDefaults.Appalication.set(optionNum, forKey: .appOptionVersionNumber)

        }
        
    }
    
    static func alertUpdate(isForce: Bool, buttonTitle: String?, content: String?, url: String?){
        guard  let myButtonTitle: String = buttonTitle,let  myContent: String = content, let myUrl: String = url, let openUrl: URL = URL(string: myUrl) else {
            return
        }
        let alertController: UIAlertController = UIAlertController(title: "New Version", message: myContent, preferredStyle: .alert)

        if isForce == false {
            let laterAction: UIAlertAction = UIAlertAction(title: "Later", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(laterAction)

            let updateAction: UIAlertAction = UIAlertAction(title: myButtonTitle, style: UIAlertActionStyle.default, handler: { (action) in
                UIApplication.shared.open(openUrl, options: [:], completionHandler: nil)
            })
            alertController.addAction(updateAction)
        }else{
            let updateAction: UIAlertAction = UIAlertAction(title: myButtonTitle, style: UIAlertActionStyle.cancel, handler: { (action) in
                UIApplication.shared.open(openUrl, options: [:], completionHandler: { (completion) in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        alertUpdate(isForce: true, buttonTitle: myButtonTitle, content: myContent, url: myUrl)
                    })

                })
            })
            alertController.addAction(updateAction)
        }
        CurrentControllerHelper.presentViewController(viewController: alertController)
        
    }
    
    //MARK:系统版本判断
    class func versionEqual(v:String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) == .orderedSame
    }
    
    class func versionThan(v:String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) == .orderedDescending
    }
    
    class func versionThanOrEqual(v:String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) != .orderedAscending
    }
    
    class func versionLess(v:String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) == .orderedAscending
    }
    
    class func versionLessOrEqual(v:String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) != .orderedDescending
    }
    
    class func resetEverydayData() {
        //重置每日的数据
        
    }
    
    
    func arm() -> Int {
        switch (__WORDSIZE / CHAR_BIT) {
        case 4:
            return 1
        case 8:
            return 2
        default:
            return 0
        }
    }
    
}

func openURL(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: options, completionHandler: completion)
    } else {
        UIApplication.shared.openURL(url)
    }}

