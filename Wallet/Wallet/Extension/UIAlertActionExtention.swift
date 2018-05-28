//
//  UIAlertActionExtention.swift
//  AsteroidVPN-iOS
//
//  Created by yidahis on 2018/1/18.
//  Copyright © 2018年 Maynard. All rights reserved.
//

import UIKit

private var catKey: UInt8 = 0 // 我们还是需要这样的模板

extension UIAlertAction{
    
    /// 添加索引
    var index: Int {
        get {
            return objc_getAssociatedObject(self, &catKey) as? Int ?? 0
        }
        set { objc_setAssociatedObject(self, &catKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}
