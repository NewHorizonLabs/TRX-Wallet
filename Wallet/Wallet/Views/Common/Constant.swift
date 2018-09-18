//
//  Constants.swift
//  RayboWallet
//
//  Created by feiyu on 2017/4/26.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import UIKit

let constant = Constant()

// MARK:- const value
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let currentVesion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "0.0"
let ySpace: CGFloat = 8
let gXLeading: CGFloat = 15
let xSpace: CGFloat = 10

struct Constant {
    
    // MARK:- const string
    /* 用于 info.plist 存储当前版本号的 key */
    let sandboxVesion = "CFBundleShortVersionString"
   
    
}

public func DAssertionFailure(_ message:Any...,file:String = #file,row:Int = #line){
    #if DEBUG
        if let filename = (file as String).components(separatedBy: "/").last {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd hh:mm:ss:SSS"
            let dateString = formatter.string(from: Date())
            assertionFailure("[\(dateString) \(String(describing: filename))-\(row)]:\(message)")
        }
    #endif
}

public func DAssertionFailureDataErr(){
    DAssertionFailure("数据异常")
}
