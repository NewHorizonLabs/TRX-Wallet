// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import Moya

enum TronAPI {
    case getTrxRate
}

extension TronAPI: TargetType {
    var baseURL: URL { return URL(string: Constants.tronAPI)! }

    var path: String {
        switch self {
        case .getTrxRate:
            return "/v1/ticker/tronix"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getTrxRate:
            var params: [String: Any] = ["convert": "EUR"]
            return .requestParameters(parameters: params, encoding: URLEncoding())
        }
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
