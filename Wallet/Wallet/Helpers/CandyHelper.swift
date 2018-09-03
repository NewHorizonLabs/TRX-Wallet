// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import PromiseKit
import Moya
import JSONRPCKit
import APIKit
import Result
import BigInt
import RxSwift
import Alamofire
import ObjectMapper

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

func plugins() -> [PluginType]{
    var plugins: [PluginType] = [PluginType]()
    
    #if DEBUG
    plugins.append(NetworkLoggerPlugin(verbose: true, responseDataFormatter:JSONResponseDataFormatter ))
    
    let activity =  NetworkActivityPlugin(networkActivityClosure: { (change, target) in
        print(change)
        print(target)
    })
    plugins.append(activity)
    #endif
    
    return plugins
}

extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }

protocol CandyNetworkProtocol {
    var provider: MoyaProvider<TronAPI> { get }
}

class TronHelper: CandyNetworkProtocol {
    static let shared: TronHelper = TronHelper()

    internal lazy var provider = MoyaProvider<TronAPI>(endpointClosure: self.endpointClosure, plugins: plugins())
    static let deleteMissingInternalSeconds: Double = 60.0
    static let deleyedTransactionInternalSeconds: Double = 60.0
    fileprivate var endpointClosure = { (target: TronAPI) -> Endpoint<TronAPI> in
        return MoyaProvider.defaultEndpointMapping(for: target)
    }
    
    func getRate() -> Observable<[RateResult]> {
        return provider.rx.request(TronAPI.getTrxRate)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: RateResult.self)
    }
    
    
}

class RateResult: NSObject, Mappable {
    var id: String?
    var percent_change_24h: String?
    var max_supply: String?
    
    var a24h_volume_eur: String?
    var price_eur: String?
    var symbol: String?
    var last_updated: String?
    var market_cap_usd: String?
    var price_usd: String?
    var percent_change_7d: String?
    var rank: String?
    var a24h_volume_usd: String?
    var market_cap_eur: String?
    var price_btc: String?
    var available_supply: String?
    var total_supply: String?
    var name: String?
    var percent_change_1h: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        percent_change_24h <- map["percent_change_24h"]
        max_supply <- map["max_supply"]
        a24h_volume_eur <- map["24h_volume_eur"]
        price_eur <- map["price_eur"]
        symbol <- map["symbol"]
        last_updated <- map["last_updated"]
        market_cap_usd <- map["market_cap_usd"]
        price_usd <- map["price_usd"]
        
        percent_change_7d <- map["percent_change_7d"]
        rank <- map["rank"]
        a24h_volume_usd <- map["24h_volume_usd"]
        market_cap_eur <- map["market_cap_eur"]
        price_btc <- map["price_btc"]
        available_supply <- map["available_supply"]
        total_supply <- map["total_supply"]
        name <- map["name"]
        percent_change_1h <- map["percent_change_1h"]
    }
}
