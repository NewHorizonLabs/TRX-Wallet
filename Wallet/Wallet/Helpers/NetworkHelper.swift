//
//  NetworkHelper.swift
//  RayboWallet
//
//  Created by Maynard on 2018/2/8.
//  Copyright © 2018年 Maynard. All rights reserved.
//

import UIKit
import CoreTelephony
import Alamofire
import RxSwift
import RxCocoa

class NetworkHelper: NSObject {
    static let shared = NetworkHelper()
    let reachabilityManager = NetworkReachabilityManager()
    var networkTypeString: String?
    var netState: Variable<NetworkReachabilityManager.NetworkReachabilityStatus> = Variable(.unknown)
    
    override init() {
        super.init()
        listenForReachability()
    }
    
    func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            self.netState.value = status
        }
        self.reachabilityManager?.startListening()
    }
    
    //  Converted to Swift 4 by Swiftify v4.1.6640 - https://objectivec2swift.com/
    func getNetconnType(type: NetworkReachabilityManager.ConnectionType) -> String? {
        
        if type == .ethernetOrWiFi{
            return "wifi"
        }
        var netconnType = ""
        // 手机自带网络
        // 获取手机网络类型
        let info = CTTelephonyNetworkInfo()
        let currentStatus: String? = info.currentRadioAccessTechnology
        if (currentStatus == "CTRadioAccessTechnologyGPRS") {
            netconnType = "GPRS"
        }
        else if (currentStatus == "CTRadioAccessTechnologyEdge") {
            netconnType = "2.75G EDGE"
        }
        else if (currentStatus == "CTRadioAccessTechnologyWCDMA") {
            netconnType = "3G"
        }
        else if (currentStatus == "CTRadioAccessTechnologyHSDPA") {
            netconnType = "3.5G HSDPA"
        }
        else if (currentStatus == "CTRadioAccessTechnologyHSUPA") {
            netconnType = "3.5G HSUPA"
        }
        else if (currentStatus == "CTRadioAccessTechnologyCDMA1x") {
            netconnType = "2G"
        }
        else if (currentStatus == "CTRadioAccessTechnologyCDMAEVDORev0") {
            netconnType = "3G"
        }
        else if (currentStatus == "CTRadioAccessTechnologyCDMAEVDORevA") {
            netconnType = "3G"
        }
        else if (currentStatus == "CTRadioAccessTechnologyCDMAEVDORevB") {
            netconnType = "3G"
        }
        else if (currentStatus == "CTRadioAccessTechnologyeHRPD") {
            netconnType = "HRPD"
        }
        else if (currentStatus == "CTRadioAccessTechnologyLTE") {
            netconnType = "4G"
        }
        return netconnType
    }

}
