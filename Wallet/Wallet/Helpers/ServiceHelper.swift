//
//  ServiceHelper.swift
//  Wallet
//
//  Created by Maynard on 2018/5/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import TrustCore
import TrustKeystore
//39.105.66.80
//47.254.39.153
//47.89.244.227
//solidity node
class ServiceHelper: NSObject {
    static let shared = ServiceHelper()
    static let fullNode: String = "47.91.246.252:50051"
    static let solidityNode: String = "47.89.244.227:50051"
    let service: TWallet = TWallet(host: ServiceHelper.fullNode)
    let solidityService: WalletExtension = WalletExtension(host: ServiceHelper.solidityNode)
    var account: Variable<TronAccount?> = Variable(nil)
    var trustAccount: TrustKeystore.Account?
    var isWatchMode: Variable<Bool> = Variable(false)
    var walletMode: Variable<WalletModeState> = Variable(.hot)
    
    var currentWallet: Wallet? {
        didSet {
            if let w = currentWallet {
                let a = TronAccount()
                a.address = w.address.data
                account.value = a
                keystore.recentlyUsedWallet = w
                trustAccount = keystore.getAccount(for: w.address)
                if w.type == .address(w.address) {
                    isWatchMode.value = true
                } else {
                    isWatchMode.value = false
                }
            }
        }
    }
    var keystore: EtherKeystore = EtherKeystore.shared
    var voteArray: [Vote] = []
    
    //钱包切换
    var walletChange: PublishSubject<Void> = PublishSubject<()>()
    //发行了token
    var tokenChange: PublishSubject<Void> = PublishSubject<()>()
    //vote
    var voteChange: PublishSubject<Void> = PublishSubject<()>()
    
    var balance: String {
        if let number = account.value?.balance {
            return String(number/1000000)
        }
        return ""
    }
    
    func reset(wallet: Wallet) {
        self.currentWallet = wallet
        self.getAccount()
        walletChange.onNext(())
    }
    
    override init() {
        super.init()
        GRPCCall.useInsecureConnections(forHost: ServiceHelper.fullNode)
        GRPCCall.useInsecureConnections(forHost: ServiceHelper.solidityNode)
        currentWallet = keystore.recentlyUsedWallet ?? keystore.wallets.first!

        if let w = currentWallet {
            let a = TronAccount()
            a.address = w.address.data
            account.value = a
            trustAccount = keystore.getAccount(for: w.address)
            keystore.recentlyUsedWallet = w
            if w.type == .address(w.address) {
                isWatchMode.value = true
            } else {
                isWatchMode.value = false
            }
        }
    }
    
    func getAccount() {
        guard let a = account.value else {
            return
        }
        service.getAccountWithRequest(a) {[weak self] (accountModel, error) in
            if let model = accountModel, a.address.addressString == model.address.addressString {
                self?.account.value = model
                if let array = model.votesArray as? [Vote] {
                    self?.voteArray = array
                }
            }
        }
    }
    
    func getAccount(account: TronAccount) -> Observable<TronAccount> {
        return Observable.create({ (observer) -> Disposable in
            self.service.getAccountWithRequest(account) { (accountModel, error) in
                if let model = accountModel {
                    observer.onNext(model)
                } else if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
        
    }
    
    func getTransactions(account: TronAccount) -> Observable<[TronTransaction]> {
        return Observable.combineLatest(self.getFromTransactions(account: account), self.getToTransactions(account: account)) { (list1, list2) -> [TronTransaction] in
            return list1 + list2
        }.asObservable()
    }
    
    private func getFromTransactions(account: TronAccount) -> Observable<[TronTransaction]> {
        return Observable.create({ (observer) -> Disposable in
            let pageAccount = AccountPaginated()
            pageAccount.account = account
            pageAccount.offset = 0
            pageAccount.limit = 100
            
            self.solidityService.getTransactionsFromThis(withRequest: pageAccount, handler: { (list, error) in
                if let list = list?.transactionArray as? [TronTransaction] {
                    observer.onNext(list)
                } else if let error = error {
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }
    
    private func getToTransactions(account: TronAccount) -> Observable<[TronTransaction]> {
        return Observable.create({ (observer) -> Disposable in
            let pageAccount = AccountPaginated()
            pageAccount.account = account
            pageAccount.offset = 0
            pageAccount.limit = 100
            self.solidityService.getTransactionsToThis(withRequest: pageAccount, handler: { (list, error) in
                if let list = list?.transactionArray as? [TronTransaction] {
                    observer.onNext(list)
                } else if let error = error {
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }
    
    func broadcastTransaction(_ transaction: TronTransaction, completion: @escaping ((Return?, Error?) -> Void)) {
        if let signTransaction = ServiceHelper.transactionSign(transaction) {
            service.broadcastTransaction(withRequest: signTransaction, handler: completion)
        } else if let wallet = ServiceHelper.shared.currentWallet, wallet.isWatch == true {
            let coldView = ColdTransactionView.loadXib()
            if let string = transaction.data()?.hexString {
                coldView.changeQRCode(address: string)
            }
            coldView.finishBlock = {[weak self] signedTransaction in
                self?.service.broadcastTransaction(withRequest: signedTransaction, handler: completion)
            }
            coldView.cancleBlock = {[weak self] in
                let error = NSError(domain: "Cancel", code: -1, userInfo: nil)
                completion(nil, error)
            }
            coldView.popShow()
        } else {
            service.broadcastTransaction(withRequest: transaction, handler: completion)
        }
        
    }
    
    class func setTimestamp(_ transaction: TronTransaction) -> TronTransaction {
        let timeInterval:TimeInterval = (Date().timeIntervalSince1970) * 1000
        transaction.rawData.timestamp = Int64(timeInterval)
        return transaction
    }
    
    class func transactionSign(_ transaction: TronTransaction) -> TronTransaction? {
        //在sha256 之前设置时间戳，否则验签失败
        ServiceHelper.setTimestamp(transaction)
        guard let addressData = ServiceHelper.shared.account.value?.address, let hash = transaction.rawData.data()?.sha256(), let account = ServiceHelper.shared.trustAccount else {
            return nil
        }

        if let list = transaction.rawData.contractArray {
            for _ in list {
                let result = ServiceHelper.shared.keystore.signHash(hash, for: account)
                switch result {
                case .success(let data):
                    transaction.signatureArray.add(data)
                case .failure:
                    break
                }
            }
        }
//        ServiceHelper.setTimestamp(transaction)
        return transaction
    }
    
}

extension EtherKeystore {
//    func signTronTransaction(_ transaction: TronTransaction) -> Result<Data, KeystoreError> {
//        guard let address = ServiceHelper.shared.currentWallet?.address, let account = self.getAccount(for: address) else {
//            return .failure(.failedToSignTransaction)
//        }
//        guard let password = getPassword(for: account) else {
//            return .failure(.failedToSignTransaction)
//        }
//        let signer: Signer
//        if transaction.chainID == 0 {
//            signer = HomesteadSigner()
//        } else {
//            signer = EIP155Signer(chainId: BigInt(transaction.chainID))
//        }
//
//        do {
//            let hash = signer.hash(transaction: transaction)
//            let signature = try keyStore.signHash(hash, account: account, password: password)
//            let (r, s, v) = signer.values(transaction: transaction, signature: signature)
//            let data = RLP.encode([
//                transaction.nonce,
//                transaction.gasPrice,
//                transaction.gasLimit,
//                transaction.to?.data ?? Data(),
//                transaction.value,
//                transaction.data,
//                v, r, s,
//                ])!
//            return .success(data)
//        } catch {
//            return .failure(.failedToSignTransaction)
//        }
//    }
}

struct AccountAsset {
    var name: String
    var balance: String
}

extension TronAccount {
    var assetArray: [AccountAsset] {
        var array: [AccountAsset] = []
        self.asset.enumerateKeysAndInt64s({ (name, value, finished) in
            array.append(AccountAsset(name: name, balance: Double(value).numberFormat()))
        })
        return array
    }
}

extension Data {
    var addressString: String {
        return String(base58CheckEncoding: self)
    }
}

extension String {
    var base58CheckData: Data? {
        return Data(base58CheckDecoding: self)
    }
}

extension Int64 {
    var string: String {
        return String(self)
    }
    
    var dateString: String {
        let timeInterval = TimeInterval(self)/1000
        return Date(timeIntervalSince1970: timeInterval).formatterString
    }
    
    var balanceString: String {
        return String(Double(self)/1000000.0)
    }
}

extension Int32 {
    var trxValue: Int32 {
        return self/1000000
    }
}

extension Int64 {
    var trxValue: Int64 {
        return self/1000000
    }
}

extension Return {
    var errorMessage: String {
        let code = self.code
        switch code {
        
        case .gpbUnrecognizedEnumeratorValue:
            return R.string.tron.errorOther()
        case .success:
            return R.string.tron.hudSuccess()
        case .sigerror:
            return R.string.tron.errorSig()
        case .contractValidateError:
            return R.string.tron.errorContractValidate()
        case .contractExeError:
            return R.string.tron.errorContractExe()
        case .bandwithError:
            return R.string.tron.errorBandwidth()
        case .dupTransactionError:
            return R.string.tron.errorDupTransaction()
        case .taposError:
            return R.string.tron.errorTapos()
        case .tooBigTransactionError:
            return R.string.tron.errorTooBigTransaction()
        case .transactionExpirationError:
            return R.string.tron.errorTransactionExpiration()
        case .serverBusy:
            return R.string.tron.errorServerBusy()
        case .otherError:
            return R.string.tron.errorOther()
        }
    }
}

extension Wallet {
    var isWatch: Bool {
        if self.type == .address(self.address) {
            return true
        } else {
            return false
        }
    }
}
