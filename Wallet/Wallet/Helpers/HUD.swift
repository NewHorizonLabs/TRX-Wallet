//
//  HUD.swift
//  RayboWallet
//
//  Created by Maynard on 2017/5/11.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import Foundation

struct HUD {
    enum ToastPosition {
        case top
        case bottom
    }
    
    static func configure() {
        
    }
    
    static func toast(_ text: String) {
        
    }
    
    static func toast(_ text: String, bottomOffset: CGFloat) {
        
    }
    
    static func toast(_ text: String,position: ToastPosition, textColor: UIColor){
        
    }
    
    static func cancleAll() {
        
    }
    
//    static func loading() {
//        KRProgressHUD.show()
//    }
    
    static func loading(text: String) {
//        KRProgressHUD.show(withMessage: text, completion: nil)
        SwiftNotice.clear()
        SwiftNotice.wait([], timeInterval: 0, text: text)
    }
    
    static func loading(text: String, onViewController: UIViewController) {
        SwiftNotice.clear()
        onViewController.pleaseWaitWithImages([], timeInterval: 0, text: text)
    }
    
    static func hideLoading() {
//        KRProgressHUD.dismiss()
        SwiftNotice.clear()
    }
    
    static func error(view: UIView, error: String) {
        SwiftNotice.clear()
        SwiftNotice.showNoticeWithText(.error, text: error, autoClear: true, autoClearTime: 2)
    }
    
    static func showText(text: String) {
        SwiftNotice.clear()
        SwiftNotice.showText(text, autoClear: true, autoClearTime: 2)
    }
    
    static func showError(error: String) {
        SwiftNotice.clear()
        SwiftNotice.showNoticeWithText(.error, text: error, autoClear: true, autoClearTime: 2)
    }

}
