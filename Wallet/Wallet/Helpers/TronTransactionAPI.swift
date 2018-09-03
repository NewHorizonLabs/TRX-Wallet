//
//  TronTransactionAPI.swift
//  TRXWallet
//
//  Created by Maynard on 2018/9/3.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import Foundation
import Moya

enum TronTransactionAPI {
    case getTransactions(address: String, limit: String, start: String)
}

extension TronTransactionAPI: TargetType {
    var baseURL: URL { return URL(string: Constants.tronTransactionAPI)! }
    
    var path: String {
        switch self {
        case .getTransactions:
            return "/api/transaction"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getTransactions:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding())
        }
    }
    
    var parameters: [String: Any]? {
        var dic:[String: Any] = [:]
        switch self {
        case .getTransactions(let address, let limit, let start):
            dic["address"] = address
            dic["limit"] = limit
            dic["start"] = start
        }
        return dic
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [
            "Content-type": "application/json",
            "client": Bundle.main.bundleIdentifier ?? "",
            "client-build": Bundle.main.buildNumber ?? "",
        ]
    }
}

