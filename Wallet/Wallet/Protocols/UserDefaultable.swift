//
//  UserDefaultable.swift
//  Sports
//
//  Created by Maynard on 2017/4/19.
//  Copyright © 2017年 Maynard. All rights reserved.
//

import Foundation
protocol KeyNamespaceable { }

extension KeyNamespaceable {
    private static func namespace(_ key: String) -> String {
        return "\(Self.self).\(key)"
    }
    
    static func namespace<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
        return namespace(key.rawValue)
    }
}


// MARK: - Bool Defaults

protocol BoolUserDefaultable : KeyNamespaceable {
    associatedtype BoolDefaultKey : RawRepresentable
}

extension BoolUserDefaultable where BoolDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ bool: Bool, forKey key: BoolDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(bool, forKey: key)
    }
    
    // Get
    
    static func bool(forKey key: BoolDefaultKey) -> Bool {
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}


// MARK: - Float Defaults

protocol FloatUserDefaultable : KeyNamespaceable {
    associatedtype FloatDefaultKey : RawRepresentable
}

extension FloatUserDefaultable where FloatDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ float: Float, forKey key: FloatDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(float, forKey: key)
    }
    
    // Get
    
    static func float(forKey key: FloatDefaultKey) -> Float {
        let key = namespace(key)
        return UserDefaults.standard.float(forKey: key)
    }
}


// MARK: - Integer Defaults

protocol IntegerUserDefaultable : KeyNamespaceable {
    associatedtype IntegerDefaultKey : RawRepresentable
}

extension IntegerUserDefaultable where IntegerDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ integer: Int, forKey key: IntegerDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(integer, forKey: key)
    }
    
    // Get
    
    static func integer(forKey key: IntegerDefaultKey) -> Int {
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
}


// MARK: - Object Defaults

protocol ObjectUserDefaultable : KeyNamespaceable {
    associatedtype ObjectDefaultKey : RawRepresentable
}

extension ObjectUserDefaultable where ObjectDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ object: AnyObject, forKey key: ObjectDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(object, forKey: key)
    }
    
    // Get
    
    static func object(forKey key: ObjectDefaultKey) -> Any? {
        let key = namespace(key)
        return UserDefaults.standard.object(forKey: key)
    }
}


// MARK: - Double Defaults

protocol DoubleUserDefaultable : KeyNamespaceable {
    associatedtype DoubleDefaultKey : RawRepresentable
}

extension DoubleUserDefaultable where DoubleDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ double: Double, forKey key: DoubleDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(double, forKey: key)
    }
    
    // Get
    
    static func double(forKey key: DoubleDefaultKey) -> Double {
        let key = namespace(key)
        return UserDefaults.standard.double(forKey: key)
    }
}

protocol StringUserDefaultable : KeyNamespaceable {
    associatedtype StringDefaultKey : RawRepresentable
}

extension StringUserDefaultable where StringDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ string: String, forKey key: StringDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(string, forKey: key)
    }
    
    // Get
    
    static func string(forKey key: StringDefaultKey) -> String? {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key)
    }
}



// MARK: - URL Defaults

protocol URLUserDefaultable : KeyNamespaceable {
    associatedtype URLDefaultKey : RawRepresentable
}

extension URLUserDefaultable where URLDefaultKey.RawValue == String {
    
    // Set
    
    static func set(_ url: URL, forKey key: URLDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(url, forKey: key)
    }
    
    // Get
    
    static func url(forKey key: URLDefaultKey) -> URL? {
        let key = namespace(key)
        return UserDefaults.standard.url(forKey: key)
    }
}


// MARK: - Use

// Preparation

//用法示意
/*
 UserDefaults.Set.set("abc", forKey: .feedbackDraft)
 let string = UserDefaults.Set.string(forKey: .feedbackDraft)
 */

extension UserDefaults {
    
    //app 相关
    struct Appalication: BoolUserDefaultable {
        enum BoolDefaultKey : String {
            //是否是第一次启动应用
            case haveLoadFirstTime
            case welcomeShowed
        }
    }
    
    //设置相关
    struct Set : StringUserDefaultable {
        private init() { }
        
        enum StringDefaultKey : String {
            //意见反馈草稿
            case feedbackDraft
        }
    }
    
    //健康数据
    struct HealthData: StringUserDefaultable, FloatUserDefaultable, ObjectUserDefaultable {
        enum StringDefaultKey : String {
            //性别
            case gender
            case fitnessGoal
            case fitnessLevel
            case weightUnit
            case heightUnit
        }
        
        enum FloatDefaultKey: String {
            //身高
            case height
            //体重
            case weight
        }
        
        enum ObjectDefaultKey: String {
            case birthDay
        }
    }
    
    //运动过程
    struct Sport: BoolUserDefaultable {
        enum BoolDefaultKey: String {
            //运动页是否静音
            case isMute
            //是否自动跳过记次运动
            case isAutoComplete
            //是否已经关闭切换模式提示框
            case isCloseModeTipView
        }
    }
    
    struct Result: BoolUserDefaultable {
        enum BoolDefaultKey: String {
            case haveShowFeedback
        }
    }
    
    struct Realm: BoolUserDefaultable {
        enum BoolDefaultKey: String {
            case isUpdate
        }
    }
    
    struct User: StringUserDefaultable {
        enum StringDefaultKey : String {
            case localUserInfo
            case personalList
        }
        
    }
}
