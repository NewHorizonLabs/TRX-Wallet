//
//  AppDelegate.swift
//  Wallet
//
//  Created by Maynard on 2018/5/4.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Bugly
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var protectionCoordinator: ProtectionCoordinator = {
        return ProtectionCoordinator()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UserDefaults.Set.set("", forKey: .fullnode)
        let isfirstLoad = !UserDefaults.Appalication.bool(forKey: .haveLoadFirstTime)
        if isfirstLoad {
            //清除密码锁keychain 数据
            Lock().clear()
            EtherKeystore.shared.clear()
            UserDefaults.Appalication.set(true, forKey: .haveLoadFirstTime)
        }
        FirebaseApp.configure()
        
        RemoteConfigureHelper.configure()
        protectionCoordinator.didFinishLaunchingWithOptions()
        UIConfigure.tabbar()
        UIConfigure.navgationBar()
        //键盘
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        //如果有钱包,进入首页
        if let _ = EtherKeystore.shared.recentlyUsedWallet ??  EtherKeystore.shared.wallets.first {
            
        } else {
            //注册
            if let window = self.window {
                window.rootViewController = R.storyboard.login.instantiateInitialViewController()
                window.makeKeyAndVisible()
            }
        }
        Bugly.start(withAppId: "caabd09c78")
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        protectionCoordinator.applicationWillResignActive()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        protectionCoordinator.applicationDidBecomeActive()
        UIConfigure.button()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        protectionCoordinator.applicationDidEnterBackground()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        protectionCoordinator.applicationWillEnterForeground()
    }


}

