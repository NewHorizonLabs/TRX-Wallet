// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import TrustCore

enum Errors: LocalizedError {
    case invalidAddress
    case invalidAmount

    var errorDescription: String? {
        switch self {
        case .invalidAddress:
            return NSLocalizedString("send.error.invalidAddress", value: "Invalid TrustCore.Address", comment: "")
        case .invalidAmount:
            return NSLocalizedString("send.error.invalidAmount", value: "Invalid Amount", comment: "")
        }
    }
}

extension TrustCore.Address {
    static var zero: TrustCore.Address {
        return TrustCore.Address(string: "0x0000000000000000000000000000000000000000")!
    }
}
