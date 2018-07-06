//
//  RemoteConfigureHelper.swift
//  SoloFitness
//
//  Created by Maynard on 2017/5/8.
//  Copyright © 2017年 赤子城. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigureHelper {
    
    enum RemoteConfigure: String {
        
        //版本更新
        case forceVersion //强制版本号
        case forceVersionDescription  //强制版本更新信息
        case forceVersionDownloadURL  // 强制版本下载地址
        case forceVersionButtonDescription //强制升级按钮文案
        
        case optionalVersion //推荐升级版本号
        case optionalVersionDescription  //推荐升级版本更新信息
        case optionalVersionDownloadURL  // 推荐升级版本下载地址
        case optionalVersionButtonDescription //推荐升级按钮文案
        
    }
    
    //注意，要在firebase configure 之后
    class func configure() {
        
        let configure = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        configure.configSettings = remoteConfigSettings!
        configure.setDefaults(fromPlist: "RemoteConfigDefaults")
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 60) { (status, error) in
            let configure = RemoteConfig.remoteConfig()
            if status == .success {
                configure.activateFetched()
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                RemoteConfigureHelper.updateConfigure()
            }
        }
    }
    
    class func updateConfigure() {


    }
    
    class func boolValue(_ key: RemoteConfigure) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
    class func stringValue(_ key: RemoteConfigure) -> String? {
        return RemoteConfig.remoteConfig().configValue(forKey: key.rawValue).stringValue
    }
    
    class func numberValue(_ key: RemoteConfigure) -> NSNumber? {
        return RemoteConfig.remoteConfig()[key.rawValue].numberValue
    }
    
    
}
