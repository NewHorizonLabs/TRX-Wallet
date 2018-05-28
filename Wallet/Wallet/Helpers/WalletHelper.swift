//
//  WalletHelper.swift
//  Wallet
//
//  Created by Maynard on 2018/5/4.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import Result
import Result
import KeychainSwift
import CryptoSwift
import TrustCore
import TrustKeystore

class WalletHelper: NSObject {
    class func createInstantWallet(password: String, completion: @escaping (Result<TrustKeystore.Account, KeystoreError>) -> Void) {
        
        let keystore = EtherKeystore.shared
        keystore.createAccount(with: password, completion: completion)
    }
    
}
