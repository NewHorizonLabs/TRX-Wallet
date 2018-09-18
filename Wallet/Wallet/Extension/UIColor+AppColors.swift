//
//  UIColor+AppColors.swift
//  RayboWallet
//
//  Created by RayboWallet on 2017/12/26.
//  Copyright © 2017年 RayboWallet. All rights reserved.
//
import UIKit

extension UIColor {
    open class var menuBackgroundColor: UIColor {
        return UIColor.rgb(r: 53, g: 78, b: 134)
    }
    
    //主题色
    class var mainNormalColor: UIColor {
        return UIColor.colorWithHex(hex: "#C23631")
    }
    
    //高亮状态主题色
    class var mainHighlightColor: UIColor {
        return UIColor.colorWithHex(hex: "#777589")
    }
    
    class var mainDeepGrayColor: UIColor {
        return UIColor.rgb(r: 82, g: 80, b: 108)
    }
    
    //导航栏颜色
    class var navigationBarColor: UIColor {
        return UIColor.mainNormalColor
    }
    
    //分割线颜色
    class var lineColor: UIColor {
        //242 242 245
        return UIColor.colorWithHex(hex: "#F3F3F3")
    }
    
    //深色分割线
    class var deepLineColor: UIColor {
        //117 117 182
        return UIColor.mainNormalColor
    }
    
    //主题红色
    class var mainRedColor: UIColor {
        //248 2 70
        return UIColor.colorWithHex(hex: "#D71A19")
    }
    //主题灰
    class var mainGrayColor: UIColor{
        return UIColor.rgb(r: 168, g: 168, b: 168)
    }
    
    //购买页蓝
    class var vipBlueColor: UIColor{
        return UIColor.rgb(r: 138, g: 188, b: 255)
    }
    //蒙层颜色
    class var maskBackgroundColor: UIColor {
        return .init(white: 0, alpha: 0.6)
    }
    
    //比主标题更深的标题颜色
    class var deepTitleColor: UIColor {
        //39 38 52
        return UIColor.colorWithHex(hex: "#272634")
    }
    
    //主标题颜色
    class var titleColor: UIColor {
        return UIColor.mainNormalColor
    }
    
    //副标题颜色
    class var subTitleColor: UIColor {
        return UIColor.colorWithHex(hex: "#2d2d2d")
    }
    
    class var normalTextColor: UIColor {
        return UIColor.colorWithHex(hex: "#212837")
    }
    
    class var disabledTextColor: UIColor {
        return UIColor.rgb(r: 255, g: 255, b: 255, a: 0.5)
    }
    
    class var normalBackgroundColor: UIColor {
        return UIColor.mainNormalColor
    }
    
    class var disabledBackgroundColor: UIColor {
        return UIColor.rgb(r: 194, g: 54, b: 49, a: 0.5)
    }
    
    //副标题颜色
    class var separatorLineColor: UIColor {
        return UIColor.rgb(r: 200, g: 199, b: 204)
    }
    
    //比副标题更浅的标题颜色
    class var lightTitleColor: UIColor {
        //153 153 153
        return UIColor.colorWithHex(hex: "#999999")
    }
    
    //背景色
    class var backgroundColor: UIColor {
        //242 242 245
        return UIColor.colorWithHex(hex: "#f3f3f3")
    }
    
    //数据为空时，提示标题颜色
    class var emptyTitleColor: UIColor {
        //242 242 242
        return UIColor.colorWithHex(hex: "#f2f2f2")
    }
    
    //tableview cell选中的时候的颜色
    class var tableViewCellSelectedColor: UIColor {
        //245 245 245
        return UIColor.colorWithHex(hex: "#f5f5f5")
    }
    
    //tableview cell normal 状态下背景色
    class var tableViewCellNormalColor: UIColor {
        return UIColor.white
    }
    
    //红色
    class var fitnessRed: UIColor {
        return UIColor.rgb(r: 248, g: 97, b: 97)
    }
    
    //绿色
    class var fitnessGreen: UIColor {
        return UIColor.rgb(r: 79, g: 196, b: 135)
    }
    
    //蓝色
    class var fitnessBlue: UIColor {
        return UIColor.rgb(r: 27, g: 136, b: 255)
    }
    
    //黄色
    class var fitnessYellow: UIColor {
        return UIColor.rgb(r: 255, g: 199, b: 64)
    }
    
    //紫色
    class var fitnessPurple: UIColor {
        return UIColor.rgb(r: 152, g: 101, b: 242)
    }
    
    //运动过程中绿色进度条颜色
    class var sportProgressGreenColor: UIColor {
        return UIColor.circleGreenColor
    }
    
    //运动过程中灰色进度条颜色
    class var sportProgressGrayColor: UIColor {
        return UIColor.rgb(r: 177, g: 177, b: 182)
    }
    
    //性别选择男
    class var maleColor: UIColor {
        return UIColor.rgb(r: 46, g: 111, b: 253)
    }
    
    //性别选择女
    class var femaleColor: UIColor {
        return UIColor.rgb(r: 253, g: 1, b: 132)
    }
    
    class var shareButtonColor: UIColor{
        return UIColor.rgb(r: 25, g: 167, b: 120)
    }
    
    class var circleGreenColor: UIColor {
        return UIColor.rgb(r: 24, g: 167, b: 120)
    }
    
    class func rgb(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    class func rgb(r: Int, g: Int, b: Int, a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    class var homeBackgroundColor: UIColor {
        return UIColor.white
    }
    
    class var purplishGreyFontColor: UIColor {
        //100 97 118
        return UIColor.colorWithHex(hex: "#646176")
    }
    
    class var cloudyBlueFontColor: UIColor {
        //193 191 207
        return UIColor.colorWithHex(hex: "#c1bfcf")
    }
    
    class var barbiePinkLayerColor: UIColor {
        //255 51 131
        return UIColor.colorWithHex(hex: "#ff3383")
    }
    
    class var aquaMarineFontColor: UIColor {
        //91 228 194
        return UIColor.colorWithHex(hex: "#5be4c2")
    }
    
    class var brightSkyBlueFontColor: UIColor {
        //0 177 254
        return UIColor.colorWithHex(hex: "#00b1fe")
    }
    
    class var grapefruitFontColor: UIColor {
        //248 97 97
        return UIColor.colorWithHex(hex: "#f86161")
    }
    
    class var iceBackGroundColor: UIColor {
        // 230 255 249
        return UIColor.colorWithHex(hex: "#e6fff9")
    }
    
}

extension UIColor {
    class func colorWithHex(hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if cString.characters.count != 6 {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}
