//
//  TronKeyStoreKey.swift
//  Wallet
//
//  Created by Maynard on 2018/5/11.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import CryptoSwift
import Foundation
import Security
import TrustCore
import TrustKeystore

/// Key definition.
public struct TronKeyStoreKey {
    /// Ethereum address.
    public var address: TrustCore.Address
    
    /// Account type.
    public var type: TrustKeystore.AccountType
    
    /// Wallet UUID, optional.
    public var id: String?
    
    /// Key header with encrypted private key and crypto parameters.
    public var crypto: KeystoreKeyHeader
    
    /// Mnemonic passphrase
    public var passphrase = ""
    
    /// Mnemonic derivation path
    public var derivationPath = "m/44'/195'/x'"
    
    /// Key version, must be 3.
    public var version = 3
    
    /// Creates a new `Key` with a password.
    @available(iOS 10.0, *)
    public init(password: String, type: TrustKeystore.AccountType) throws {
        switch type {
        case .encryptedKey:
            let privateAttributes: [String: Any] = [
                kSecAttrIsExtractable as String: true,
                ]
            let parameters: [String: Any] = [
                kSecAttrKeyType as String: kSecAttrKeyTypeEC,
                kSecAttrKeySizeInBits as String: 256,
                kSecPrivateKeyAttrs as String: privateAttributes,
                ]
            
            var pubKey: SecKey?
            var privKey: SecKey?
            let status = SecKeyGeneratePair(parameters as CFDictionary, &pubKey, &privKey)
            guard let privateKey = privKey, status == noErr else {
                fatalError("Failed to generate key pair")
            }
            
            guard let keyRepresentation = SecKeyCopyExternalRepresentation(privateKey, nil) as Data? else {
                fatalError("Failed to extract new private key")
            }
            
            guard let publicKey = pubKey, status == noErr else {
                fatalError("Failed to generate key pair")
            }
            
            guard let pubkeyRepresentation = SecKeyCopyExternalRepresentation(publicKey, nil) as Data? else {
                fatalError("Failed to extract new private key")
            }
            var key = keyRepresentation[(keyRepresentation.count - 32)...]
            key = Data(hex: "21b76bd9595b83b24e22178b719747f799a50f30f15311ffee07b6b6db0f43f4")
            let password = key.base64EncodedString()
            
            let sha3 = Data(hex: "041638a893e6e8697e15701c3be55247c9cbf62f1469efd4dcf86b83b73f52a211a6ba36499863751963f590cdfe0922fd26c590de7ff21984d8d0a62aff17a886").subdata(in: 1..<65).sha3(.keccak256)
            var data = Data.init(hex: "a0")
            data.append(sha3.subdata(in: 12..<32))
            let address = String(base58CheckEncoding: data)
            try self.init(password: password, key: key)
        case .hierarchicalDeterministicWallet:
            let mnemonic = Mnemonic.generate(strength: 256)
            try self.init(password: password, mnemonic: mnemonic, passphrase: "")
        }
    }
    
//    /// Initializes a `Key` from a JSON wallet.
    public init(contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try JSONDecoder().decode(TronKeyStoreKey.self, from: data)
    }

    /// Initializes a `Key` by encrypting a private key with a password.
    public init(password: String, key: Data) throws {
        id = UUID().uuidString.lowercased()
        crypto = try KeystoreKeyHeader(password: password, data: key)

        let pubKey = EthereumCrypto.getPublicKey(from: key)
        address = TronKeyStoreKey.decodeAddress(from: pubKey)
        type = .encryptedKey
    }
    
    /// Initializes a `Key` by encrypting a mnemonic phrase with a password.
    public init(password: String, mnemonic: String, passphrase: String = "", derivationPath: String = TrustKeystore.Wallet.defaultPath) throws {
        id = UUID().uuidString.lowercased()
        
        guard let cstring = mnemonic.cString(using: .ascii) else {
            throw EncryptError.invalidMnemonic
        }
        let data = Data(bytes: cstring.map({ UInt8($0) }))
        crypto = try KeystoreKeyHeader(password: password, data: data)
        
        let key = TrustKeystore.Wallet(mnemonic: mnemonic, passphrase: passphrase, path: derivationPath).getKey(at: 0)
        address = key.address
        type = .hierarchicalDeterministicWallet
        self.passphrase = passphrase
        self.derivationPath = derivationPath
    }
    
    /// Decodes an Ethereum address from a public key.
    static func decodeAddress(from publicKey: Data) -> TrustCore.Address {
        precondition(publicKey.count == 65, "Expect 64-byte public key")
        precondition(publicKey[0] == 4, "Invalid public key")
        let sha3 = publicKey[1...].sha3(.keccak256)
        return TrustCore.Address(data: sha3[12..<32])
    }
    
    /// Decrypts the key and returns the private key.
    public func decrypt(password: String) throws -> Data {
        let derivedKey: Data
        switch crypto.kdf {
        case "scrypt":
            let scrypt = Scrypt(params: crypto.kdfParams)
            derivedKey = try scrypt.calculate(password: password)
        default:
            throw DecryptError.unsupportedKDF
        }

        let mac = TronKeyStoreKey.computeMAC(prefix: derivedKey[derivedKey.count - 16 ..< derivedKey.count], key: crypto.cipherText)
        if mac != crypto.mac {
            throw DecryptError.invalidPassword
        }

        let decryptionKey = derivedKey[0...15]
        let decryptedPK: [UInt8]
        switch crypto.cipher {
        case "aes-128-ctr":
            let aesCipher = try AES(key: decryptionKey.bytes, blockMode: .CTR(iv: crypto.cipherParams.iv.bytes), padding: .noPadding)
            decryptedPK = try aesCipher.decrypt(crypto.cipherText.bytes)
        case "aes-128-cbc":
            let aesCipher = try AES(key: decryptionKey.bytes, blockMode: .CBC(iv: crypto.cipherParams.iv.bytes), padding: .noPadding)
            decryptedPK = try aesCipher.decrypt(crypto.cipherText.bytes)
        default:
            throw DecryptError.unsupportedCipher
        }

        return Data(bytes: decryptedPK)
    }

    static func computeMAC(prefix: Data, key: Data) -> Data {
        var data = Data(capacity: prefix.count + key.count)
        data.append(prefix)
        data.append(key)
        return data.sha3(.keccak256)
    }
    
    /// Signs a hash with the given password.
    ///
    /// - Parameters:
    ///   - hash: hash to sign
    ///   - password: key password
    /// - Returns: signature
    /// - Throws: `DecryptError` or `Secp256k1Error`
    public func sign(hash: Data, password: String) throws -> Data {
        switch type {
        case .encryptedKey:
            var key = try decrypt(password: password)
            defer {
                // Clear memory after signing
                key.resetBytes(in: 0..<key.count)
            }
            return EthereumCrypto.sign(hash: hash, privateKey: key)
        case .hierarchicalDeterministicWallet:
            guard var mnemonic = String(data: try decrypt(password: password), encoding: .ascii) else {
                throw DecryptError.invalidPassword
            }
            defer {
                // Clear memory after signing
                mnemonic.withMutableCharacters { chars in
                    chars.replaceSubrange(chars.startIndex ..< chars.endIndex, with: [Character](repeating: " ", count: chars.count))
                }
            }
            let wallet = TrustKeystore.Wallet(mnemonic: mnemonic, passphrase: passphrase, path: derivationPath)
            return EthereumCrypto.sign(hash: hash, privateKey: wallet.getKey(at: 0).privateKey)
        }
    }
    
    /// Signs multiple hashes with the given password.
    ///
    /// - Parameters:
    ///   - hashes: array of hashes to sign
    ///   - password: key password
    /// - Returns: [signature]
    /// - Throws: `DecryptError` or `Secp256k1Error`
    public func signHashes(_ hashes: [Data], password: String) throws -> [Data] {
        switch type {
        case .encryptedKey:
            var key = try decrypt(password: password)
            defer {
                // Clear memory after signing
                key.resetBytes(in: 0..<key.count)
            }
            return hashes.map({ EthereumCrypto.sign(hash: $0, privateKey: key) })
        case .hierarchicalDeterministicWallet:
            guard var mnemonic = String(data: try decrypt(password: password), encoding: .ascii) else {
                throw DecryptError.invalidPassword
            }
            defer {
                // Clear memory after signing
                mnemonic.withMutableCharacters { chars in
                    chars.replaceSubrange(chars.startIndex ..< chars.endIndex, with: [Character](repeating: " ", count: chars.count))
                }
            }
            let wallet = TrustKeystore.Wallet(mnemonic: mnemonic)
            let key = wallet.getKey(at: 0).privateKey
            return hashes.map({ EthereumCrypto.sign(hash: $0, privateKey: key) })
        }
    }
}

public enum DecryptError: Error {
    case unsupportedKDF
    case unsupportedCipher
    case invalidCipher
    case invalidPassword
}

public enum EncryptError: Error {
    case invalidMnemonic
}

extension TronKeyStoreKey: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case type
        case id
        case crypto
        case derivationPath
        case version
    }

    enum UppercaseCodingKeys: String, CodingKey {
        case crypto = "Crypto"
    }

    struct TypeString {
        static let privateKey = "private-key"
        static let mnemonic = "mnemonic"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let altValues = try decoder.container(keyedBy: UppercaseCodingKeys.self)

        address = TrustCore.Address(data: try values.decodeHexString(forKey: .address))
        switch try values.decodeIfPresent(String.self, forKey: .type) {
        case TypeString.mnemonic?:
            type = .hierarchicalDeterministicWallet
            derivationPath = try values.decodeIfPresent(String.self, forKey: .derivationPath) ?? TrustKeystore.Wallet.defaultPath
        default:
            type = .encryptedKey
        }

        id = try values.decode(String.self, forKey: .id)
        if let crypto = try? values.decode(KeystoreKeyHeader.self, forKey: .crypto) {
            self.crypto = crypto
        } else {
            // Workaround for myEtherWallet files
            self.crypto = try altValues.decode(KeystoreKeyHeader.self, forKey: .crypto)
        }
        version = try values.decode(Int.self, forKey: .version)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address.description.dropp0x(), forKey: .address)
        switch type {
        case .encryptedKey:
            try container.encode(TypeString.privateKey, forKey: .type)
        case .hierarchicalDeterministicWallet:
            try container.encode(TypeString.mnemonic, forKey: .type)
            try container.encode(derivationPath, forKey: .derivationPath)
        }
        try container.encode(id, forKey: .id)
        try container.encode(crypto, forKey: .crypto)
        try container.encode(version, forKey: .version)
    }
}

private extension String {
    func dropp0x() -> String {
        if hasPrefix("0x") {
            return String(dropFirst(2))
        }
        return self
    }
}

