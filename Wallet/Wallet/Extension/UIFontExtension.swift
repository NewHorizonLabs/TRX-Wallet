//
//  UIFontExtension.swift
//  RayboWallet
//
//  Created by RayboWallet on 2018/1/8.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

//
//  UIFont+SFUI.swift
//  RayboWallet
//
//  Created by Maynard on 2017/5/5.
//  Copyright © 2017年 RayboWallet. All rights reserved.
//

import UIKit
import Ruler

extension UIFont {
    
    enum FontStyle: String {
        case regular = "Regular"
        case medium = "Medium"
        case light = "Light"
        case bold = "Bold"
        case semibold = "Semibold"
        case none = ""
    }
    
    enum Classify: String {
        case text = "Text"
        case display = "Display"
    }
    
    struct SF {
        static func font(style: FontStyle, size: CGFloat) -> UIFont {
            return UIFont(name: ".SFUIDisplay-\(style.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        static func font(classify: Classify, size: CGFloat) -> UIFont {
            return UIFont(name: ".SFUI\(classify.rawValue)-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        static func font(classify: Classify, style: FontStyle, size: CGFloat) -> UIFont {
            return UIFont(name: ".SFUI\(classify.rawValue)-\(style.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    struct Roboto {
        static func font(style: FontStyle, size: CGFloat) -> UIFont {
            return UIFont(name: ".Roboto-\(style.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
}

