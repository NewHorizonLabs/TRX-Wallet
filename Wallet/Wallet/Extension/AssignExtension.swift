//
//  DataExtension.swift
//  Pintuan
//
//  Created by zhouyi on 2017/8/29.
//  Copyright © 2017年 jwsszle, Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol digtalTarget {
}

extension Int: digtalTarget {
    //加1但是不能大于某个数字
    func plusOne(num:Int) -> Int {
        var a = self
        a += 1
        return a > num ? num : a
    }
    
    func equal0(num:Int) -> Int {
        return self == 0 ? num : self
    }
    
    func timeFormat() -> String {
        let seconds = self % 60
        let minutes = ((self % 3600) / 60)
        let hours = self / 3600;
        return String(format: "%02d:%02d:%02d", hours,minutes, seconds)
    }
    
    func dateStringDot() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    func fullDateString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.string(from: date)
    }
    
    public func boolValue() -> Bool {
        if self == 0 {
            return false
        }else{
            return true
        }
    }
}


extension UInt: digtalTarget {
    
}

extension Float: digtalTarget {
}

extension CGFloat {
    func numberFormat(length: Int) -> String {
        return String(format: "%.\(length)f", self)
    }
}

extension Double: digtalTarget {
    func roundTo(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
    
    func numberFormat() -> String {
        return String(format: "%.6f", self)
    }
    
    
}

extension CGFloat: digtalTarget {
    
}
extension NSNumber: digtalTarget{
    
}

extension digtalTarget {
    //屏幕比例适配
    func adapt() -> CGFloat {
        
        return medium * (UIScreen.main.bounds.width / 375.0)
    }
    //保留1位小数
    func onePoints() -> CGFloat {
        return CGFloat(floorf(Float(medium * 10)) / 10)
    }
    //保留2位小数
    func twoPoints() -> CGFloat {
        return CGFloat(floorf(Float(medium * 100)) / 100)
    }
    
    
    
    var medium:CGFloat {
        let offset: CGFloat
        if let amount = self as? Float {
            offset = CGFloat(amount)
        } else if let amount = self as? Double {
            offset = CGFloat(amount)
        } else if let amount = self as? CGFloat {
            offset = CGFloat(amount)
        } else if let amount = self as? Int {
            offset = CGFloat(amount)
        } else if let amount = self as? UInt {
            offset = CGFloat(amount)
        } else {
            offset = 0.0
        }
        return offset
    }
    
    public func pirceString() -> String{
        let price = self.twoPoints()
        
        return String(format: "%0.2f", Float(price))
    }
    
    public func toString() -> String {
        return String(format: "%.6f", self as! CVarArg)
    }
}
