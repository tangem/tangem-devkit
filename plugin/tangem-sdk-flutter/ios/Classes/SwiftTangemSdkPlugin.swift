import Flutter
import UIKit
import TangemSdk

public class SwiftTangemSdkPlugin: NSObject, FlutterPlugin {
    private lazy var sdk: TangemSdk = {
        let sdk = TangemSdk()
        sdk.config.allowedCardTypes = [.sdk]
        return sdk
    }()
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tangemSdk", binaryMessenger: registrar.messenger())
        let instance = SwiftTangemSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            switch call.method {
            case "scanCard":
                try scanCard(call.arguments, result)
            case "sign":
                try sign(call.arguments, result)
            case "personalize":
                try personalize(call.arguments, result)
            case "depersonalize":
                try depersonalize(call.arguments, result)
            case "createWallet":
                try createWallet(call.arguments, result)
            case "purgeWallet":
                try purgeWallet(call.arguments, result)
            case "readIssuerData":
                try readIssuerData(call.arguments, result)
            case "writeIssuerData":
                try writeIssuerData(call.arguments, result)
            case "readIssuerExData":
                try readIssuerExData(call.arguments, result)
            case "writeIssuerExData":
                try writeIssuerExData(call.arguments, result)
            case "readUserData":
                try readUserData(call.arguments, result)
            case "writeUserData":
                try writeUserData(call.arguments, result)
            case "writeUserProtectedData":
                try writeUserProtectedData(call.arguments, result)
            case "setPin1":
                try setPin1(call.arguments, result)
            case "setPin2":
                try setPin2(call.arguments, result)
            case "allowsOnlyDebugCards":
                allowsOnlyDebugCards(call.arguments, result)
            case "prepareHashes":
                try prepareHashes(call.arguments, result)
//            case "writeFiles":
//                try writeFiles(call.arguments, result)
            case "readFiles":
                try readFiles(call.arguments, result)
            case "deleteFiles":
                try deleteFiles(call.arguments, result)
//            case "changeFilesSettings":
//                try changeFilesSettings(call.arguments, result)
            default:
                result(FlutterMethodNotImplemented)
            }
        } catch {
            print(error)
            print(error.localizedDescription)
            handleError(error, result)
        }
    }
    
    private func scanCard(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.scanCard(initialMessage: try getArgOptional(.initialMessage, from: args),
                     pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func sign(_ args: Any?, _ completion: @escaping FlutterResult) throws {
         let hexHashes: [String] = try getArg(.hashes, from: args)
         let hashes = hexHashes.compactMap({Data(hexString: $0)})
        
        sdk.sign(hashes: hashes,
                 initialMessage: try getArgOptional(.initialMessage, from: args),
                 pin1: try getArgOptional(.pin1, from: args),
                 pin2: try getArgOptional(.pin2, from: args)
        ) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func personalize(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.personalize(config: try getArg(.cardConfig, from: args),
                        issuer: try getArg(.issuer, from: args),
                        manufacturer: try getArg(.manufacturer, from: args),
                        acquirer: try getArgOptional(.acquirer, from: args),
                        initialMessage: try getArgOptional(.initialMessage, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func depersonalize(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.depersonalize(initialMessage: try getArgOptional(.initialMessage, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func createWallet(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.createWallet(cardId: try getArgOptional(.cid, from: args),
                         initialMessage: try getArgOptional(.initialMessage, from: args),
                         pin1: try getArgOptional(.pin1, from: args),
                         pin2: try getArgOptional(.pin2, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func purgeWallet(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.purgeWallet(cardId: try getArgOptional(.cid, from: args),
                        initialMessage: try getArgOptional(.initialMessage, from: args),
                        pin1: try getArgOptional(.pin1, from: args),
                        pin2: try getArgOptional(.pin2, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func readIssuerData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.readIssuerData(cardId: try getArgOptional(.cid, from: args),
                           initialMessage: try getArgOptional(.initialMessage, from: args),
                           pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeIssuerData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.writeIssuerData(cardId: try getArg(.cid, from: args),
                            issuerData: try getArg(.issuerData, from: args),
                            issuerDataSignature: try getArg(.issuerDataSignature, from: args),
                            issuerDataCounter: try getArgOptional(.issuerDataCounter, from: args),
                            initialMessage: try getArgOptional(.initialMessage, from: args),
                            pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func readIssuerExData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.readIssuerExtraData(cardId: try getArgOptional(.cid, from: args),
                                initialMessage: try getArgOptional(.initialMessage, from: args),
                                pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeIssuerExData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.writeIssuerExtraData(cardId: try getArg(.cid, from: args),
                                 issuerData: try getArg(.issuerData, from: args),
                                 startingSignature: try getArg(.startingSignature, from: args),
                                 finalizingSignature: try getArg(.finalizingSignature, from: args),
                                 issuerDataCounter: try getArgOptional(.issuerDataCounter, from: args),
                                 initialMessage: try getArgOptional(.initialMessage, from: args),
                                 pin1: try getArgOptional(.pin1, from: args)){ [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func readUserData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.readUserData(cardId: try getArgOptional(.cid, from: args),
                         initialMessage: try getArgOptional(.initialMessage, from: args),
                         pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeUserData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.writeUserData(cardId: try getArgOptional(.cid, from: args),
                          userData: try getArg(.userData, from: args),
                          userCounter: try getArgOptional(.userCounter, from: args),
                          initialMessage: try getArgOptional(.initialMessage, from: args),
                          pin1: try getArgOptional(.pin1, from: args)){ [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeUserProtectedData(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.writeUserProtectedData(cardId: try getArgOptional(.cid, from: args),
                                   userProtectedData: try getArg(.userProtectedData, from: args),
                                   userProtectedCounter: try getArgOptional(.userProtectedCounter, from: args),
                                   initialMessage: try getArgOptional(.initialMessage, from: args),
                                   pin1: try getArgOptional(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func setPin1(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        let pin: String? = try getArgOptional(.pinCode, from: args)
        
        sdk.changePin1(cardId: try getArgOptional(.cid, from: args),
                       pin: pin?.sha256(),
                       initialMessage: try getArgOptional(.initialMessage, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func setPin2(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        let pin: String? = try getArgOptional(.pinCode, from: args)
        
        sdk.changePin2(cardId: try getArgOptional(.cid, from: args),
                       pin: pin?.sha256(),
                       initialMessage: try getArgOptional(.initialMessage, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func allowsOnlyDebugCards(_ args: Any?, _ completion: @escaping FlutterResult) {
        if let allowedOnlyDebug = (args as? [String: Any])?["isAllowedOnlyDebugCards"] as? Bool {
            sdk.config.allowedCardTypes = allowedOnlyDebug ? [.sdk] : FirmwareType.allCases
        }
    }
    
    private func prepareHashes(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        let hashes = sdk.prepareHashes(cardId: try getArg(.cid, from: args),
                                       fileData: try getArg(.fileData, from: args),
                                       fileCounter: try getArg(.fileCounter, from: args),
                                       privateKey: try getArgOptional(.privateKey, from: args))
        completion(hashes.description)
    }
    
    private func readFiles(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        let readPrivateFiles: Bool = try getArgOptional(.readPrivateFiles, from: args) ?? false
        //let indices: [Int] = try getArg(.indices, from: args)
        
        sdk.readFiles(cardId: try getArgOptional(.cid, from: args),
                      initialMessage: try getArgOptional(.initialMessage, from: args),
                      pin1: try getArgOptional(.pin1, from: args),
                      pin2: try getArgOptional(.pin2, from: args),
                      readSettings: ReadFilesTaskSettings(readPrivateFiles: readPrivateFiles)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
//    private func writeFiles(_ args: Any?, _ completion: @escaping FlutterResult) throws {
//        sdk.writeFiles(cardId: try getArgOptional(.cid, from: args),
//                       initialMessage: try getArgOptional(.initialMessage, from: args),
//                       pin1: try getArgOptional(.pin1, from: args),
//                       pin2: try getArgOptional(.pin2, from: args),
//                       files: [DataToWrite],
//                       writeFilesSettings: Set<WriteFilesSettings>) { [weak self] result in
//            self?.handleCompletion(result, completion)
//        }
//    }
    
//    private func changeFilesSettings(_ args: Any?, _ completion: @escaping FlutterResult) throws {
//        sdk.changeFilesSettings(cardId: try getArgOptional(.cid, from: args),
//                                initialMessage: try getArgOptional(.initialMessage, from: args),
//                                pin1: try getArgOptional(.pin1, from: args),
//                                pin2: try getArgOptional(.pin2, from: args),
//                                files: <#T##[File]#>) { [weak self] result in
//            self?.handleCompletion(result, completion)
//        }
//    }
    
    private func deleteFiles(_ args: Any?, _ completion: @escaping FlutterResult) throws {
        sdk.deleteFiles(cardId: try getArgOptional(.cid, from: args),
                        initialMessage: try getArgOptional(.initialMessage, from: args),
                        pin1: try getArgOptional(.pin1, from: args),
                        pin2: try getArgOptional(.pin2, from: args),
                        indicesToDelete: try getArgOptional(.indices, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func handleCompletion<TResult: JSONStringConvertible>(_ sdkResult: Result<TResult, TangemSdkError>, _ completion: @escaping FlutterResult) {
        switch sdkResult {
        case .success(let response):
            completion(response.description)
        case .failure(let error):
            handleError(error, completion)
        }
    }
    
    private func handleError(_ error: Error, _ completion: @escaping FlutterResult) {
        var pluginError: PluginError
        
        if let sdkError = error as? TangemSdkError {
            pluginError = sdkError.toPluginError()
        } else if let pluginInternalError = error as? PluginInternalError {
            pluginError = pluginInternalError.toPluginError()
        } else {
            pluginError = PluginError(code: 9998, localizedDescription: "\(error)")
        }
        
        completion(pluginError.flutterError)
    }
    
    private func getArgOptional<T: Decodable>(_ key: ArgKey, from arguments: Any?) throws -> T? {
        do {
            return try getArg(key, from: arguments)
        } catch PluginInternalError.missingArgument {
            return nil
        }
    }
    
    private func getArg<T: Decodable>(_ key: ArgKey, from arguments: Any?) throws -> T {
        if let value = (arguments as? [String: Any])?[key.rawValue] {
            if T.self == Data.self || T.self == Data?.self {
                if let hex = value as? String {
                    return (Data(hexString: hex) as! T)
                } else {
                    throw PluginInternalError.failedToParseDataFromHex(key)
                }
            } else {
                do {
                    return try decodeObject(value)
                } catch {
                    if let converted = value as? T {
                        return converted
                    } else {
                        throw error
                    }
                }
            }
        } else {
            throw PluginInternalError.missingArgument(key)
        }
    }
    
    private func decodeObject<T: Decodable>(_ value: Any) throws -> T {
        if let json = value as? String, let jsonData = json.data(using: .utf8) {
            return try JSONDecoder.tangemSdkDecoder.decode(T.self, from: jsonData)
        } else {
            throw PluginInternalError.failedToParseJson
        }
    }
}

fileprivate struct PluginError: Encodable {
    let code: Int
    let localizedDescription: String
    
    var jsonDescription: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        let data = (try? encoder.encode(self)) ?? Data()
        return String(data: data, encoding: .utf8)!
    }
    
    var flutterError: FlutterError {
        FlutterError(code: "\(code)", message: localizedDescription, details: jsonDescription)
    }
}

fileprivate extension TangemSdkError {
    func toPluginError() -> PluginError {
        return PluginError(code: code, localizedDescription: localizedDescription)
    }
}

fileprivate enum PluginInternalError: Error, LocalizedError {
    case failedToParseJson
    case missingArgument(_ value: ArgKey)
    case failedToParseDataFromHex(_ value: ArgKey)
    
    var errorDescription: String? {
        switch self {
        case .failedToParseJson:
            return "Failed to parse JSON object"
        case .missingArgument(let value):
            return "Missing required argument: \(value.rawValue)"
        case .failedToParseDataFromHex(let value):
            return "Failed to parse Data from HEX for: \(value.rawValue)"
        }
    }
    
    func toPluginError() -> PluginError {
        return PluginError(code: 9999 , localizedDescription: localizedDescription)
    }
}

fileprivate enum ArgKey: String {
    case pin1
    case pin2
    case cid
    case hashes
    case userCounter
    case userProtectedCounter
    case userData
    case issuerDataCounter
    case userProtectedData
    case issuerData
    case issuerDataSignature
    case startingSignature
    case finalizingSignature
    case issuer
    case manufacturer
    case acquirer
    case cardConfig
    case pinCode
    case initialMessage
    case fileData
    case fileCounter
    case privateKey
    case readPrivateFiles
    case indices
}

// "files" : "[{\"data\":\"ffd8ffe000104a46494600010100004800480000ffe100584578696600004d4d002a000000080002011200030000000100010000876900040000000100000026000000000003a00100030000000100010000a00200040000000100000140a0030004000000010000023800000000ffed003850686f746f73686f7020332e30003842494d04040000000000003842494d0425000000000010d41d8cd98f00b204e9800998ecf8427effc00011080238014003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a26272"
