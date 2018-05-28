// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import TrustCore

enum TransferType {
    case ether(destination: TrustCore.Address?)
    case token(TokenObject)
    case dapp(DAppRequester)
}

extension TransferType {
    func symbol(server: RPCServer) -> String {
        switch self {
        case .ether, .dapp:
            return server.symbol
        case .token(let token):
            return token.symbol
        }
    }

    // Used to fetch pricing for specific token
    func contract() -> TrustCore.Address {
        switch self {
        case .ether, .dapp:
            return TrustCore.Address(string: TokensDataStore.etherToken(for: Config()).contract)!
        case .token(let token):
            return TrustCore.Address(string: token.contract)!
        }
    }
}
