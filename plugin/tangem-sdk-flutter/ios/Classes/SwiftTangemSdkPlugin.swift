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
        switch call.method {
        case "scanCard":
            scanCard(call.arguments, result)
        case "sign":
            sign(call.arguments, result)
        case "personalize":
            personalize(call.arguments, result)
        case "depersonalize":
            depersonalize(call.arguments, result)
        case "createWallet":
            createWallet(call.arguments, result)
        case "purgeWallet":
            purgeWallet(call.arguments, result)
        case "readIssuerData":
            readIssuerData(call.arguments, result)
        case "writeIssuerData":
            writeIssuerData(call.arguments, result)
        case "readIssuerExData":
            readIssuerExData(call.arguments, result)
        case "writeIssuerExData":
            writeIssuerExData(call.arguments, result)
        case "readUserData":
            readUserData(call.arguments, result)
        case "writeUserData":
            writeUserData(call.arguments, result)
        case "writeUserProtectedData":
            writeUserProtectedData(call.arguments, result)
        case "setPin1":
            setPin1(call.arguments, result)
        case "setPin2":
            setPin2(call.arguments, result)
        case "allowsOnlyDebugCards":
            allowsOnlyDebugCards(call.arguments, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func scanCard(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.scanCard (initialMessage: getArg(.initialMessage, from: args), pin1: getArg(.pin1, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func sign(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let hexHashes: [String] = getArg(.hashes, from: args) else {
            handleMissingArgs(completion)
            return
        }
        
        let hashes = hexHashes.compactMap({Data(hexString: $0)})
        sdk.sign(hashes: hashes,
                 initialMessage: getArg(.initialMessage, from: args),
                 pin1: getArg(.pin1, from: args),
                 pin2: getArg(.pin2, from: args)
        ) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func personalize(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let config: CardConfig = getArg(.cardConfig, from: args),
            let issuer: Issuer = getArg(.issuer, from: args),
            let manufacturer: Manufacturer = getArg(.manufacturer, from: args) else {
                handleMissingArgs(completion)
                return
        }
        
        sdk.personalize(config: config,
                        issuer: issuer,
                        manufacturer: manufacturer,
                        acquirer: getArg(.acquirer, from: args),
                        initialMessage: getArg(.initialMessage, from: args)) { [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func depersonalize(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.depersonalize(initialMessage: getArg(.initialMessage, from: args)) { [weak self] result in
            self?.handleCompletion(result, completion)
        }
    }
    
    private func createWallet(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.createWallet(cardId: getArg(.cid, from: args),
                         initialMessage: getArg(.initialMessage, from: args),
                         pin1: getArg(.pin1, from: args),
                         pin2: getArg(.pin2, from: args)) { [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func purgeWallet(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.purgeWallet(cardId: getArg(.cid, from: args),
                        initialMessage: getArg(.initialMessage, from: args),
                        pin1: getArg(.pin1, from: args),
                        pin2: getArg(.pin2, from: args)) { [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func readIssuerData(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.readIssuerData(cardId: getArg(.cid, from: args),
                           initialMessage: getArg(.initialMessage, from: args),
                           pin1: getArg(.pin1, from: args)) { [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeIssuerData(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let issuerData: Data = getArg(.issuerData, from: args),
            let issuerSig: Data = getArg(.issuerDataSignature, from: args),
            let cid: String = getArg(.cid, from: args) else {
                handleMissingArgs(completion)
                return
        }
        
        sdk.writeIssuerData(cardId: cid,
                            issuerData: issuerData,
                            issuerDataSignature: issuerSig,
                            issuerDataCounter: getArg(.issuerDataCounter, from: args),
                            initialMessage: getArg(.initialMessage, from: args),
                            pin1: getArg(.pin1, from: args)) { [weak self] result in
                                self?.handleCompletion(result, completion)
        }
    }
    
    private func readIssuerExData(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.readIssuerExtraData(cardId: getArg(.cid, from: args),
                                initialMessage: getArg(.initialMessage, from: args),
                                pin1: getArg(.pin1, from: args)) { [weak self] result in
                                    self?.handleCompletion(result, completion)
        }
    }
    
    private func writeIssuerExData(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let issuerData: Data = getArg(.issuerData, from: args),
            let startSig: Data = getArg(.startingSignature, from: args),
            let finalSig: Data = getArg(.finalizingSignature, from: args),
            let cid: String = getArg(.cid, from: args) else {
                handleMissingArgs(completion)
                return
        }
    
        sdk.writeIssuerExtraData(cardId: cid,
                                 issuerData: issuerData,
                                 startingSignature: startSig,
                                 finalizingSignature: finalSig,
                                 issuerDataCounter: getArg(.issuerDataCounter, from: args),
                                 initialMessage: getArg(.initialMessage, from: args),
                                 pin1: getArg(.pin1, from: args)){ [weak self] result in
                                    self?.handleCompletion(result, completion)
        }
    }
    
    private func readUserData(_ args: Any?, _ completion: @escaping FlutterResult) {
        sdk.readUserData(cardId: getArg(.cid, from: args),
                         initialMessage: getArg(.initialMessage, from: args),
                         pin1: getArg(.pin1, from: args)) { [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeUserData(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let userData: Data = getArg(.userData, from: args) else {
            handleMissingArgs(completion)
            return
        }
        
        sdk.writeUserData(cardId: getArg(.cid, from: args),
                          userData: userData,
                          userCounter: getArg(.userCounter, from: args),
                          initialMessage: getArg(.initialMessage, from: args),
                          pin1: getArg(.pin1, from: args)){ [weak self] result in
                            self?.handleCompletion(result, completion)
        }
    }
    
    private func writeUserProtectedData(_ args: Any?, _ completion: @escaping FlutterResult) {
        guard let userProtectedData: Data = getArg(.userProtectedData, from: args) else {
            handleMissingArgs(completion)
            return
        }
        
        sdk.writeUserProtectedData(cardId: getArg(.cid, from: args),
                                   userProtectedData: userProtectedData,
                                   userProtectedCounter: getArg(.userProtectedCounter, from: args),
                                   initialMessage: getArg(.initialMessage, from: args),
                                   pin1: getArg(.pin1, from: args)) { [weak self] result in
                                    self?.handleCompletion(result, completion)
        }
    }
    
    private func setPin1(_ args: Any?, _ completion: @escaping FlutterResult) {
        let pin: String? = getArg(.pinCode, from: args)
        
        sdk.changePin1(cardId: getArg(.cid, from: args),
                       pin: pin?.sha256(),
                       initialMessage: getArg(.initialMessage, from: args)) { [weak self] result in
                        self?.handleCompletion(result, completion)
        }
    }
    
    private func setPin2(_ args: Any?, _ completion: @escaping FlutterResult) {
        let pin: String? = getArg(.pinCode, from: args)
        
        sdk.changePin2(cardId: getArg(.cid, from: args),
                       pin: pin?.sha256(),
                       initialMessage: getArg(.initialMessage, from: args)) { [weak self] result in
                        self?.handleCompletion(result, completion)
        }
    }
    
    private func allowsOnlyDebugCards(_ args: Any?, _ completion: @escaping FlutterResult) {
        if let allowedOnlyDebug = (args as? [String: Any])?["isAllowedOnlyDebugCards"] as? Bool {
            sdk.config.allowedCardTypes = allowedOnlyDebug ? [.sdk] : [.sdk, .release, .unknown]
        }
    }
    
    private func handleCompletion<TResult: ResponseCodable>(_ sdkResult: Result<TResult, TangemSdkError>, _ completion: @escaping FlutterResult) {
        switch sdkResult {
        case .success(let response):
            completion(response.description)
        case .failure(let error):
            let pluginError = error.toPluginError()
            completion(FlutterError(code: "\(pluginError.code)", message: pluginError.localizedDescription, details: pluginError.jsonDescription))
        }
    }
    
    private func handleMissingArgs(_ completion: @escaping FlutterResult) {
        let missingArgsError = PluginError(code: 9999, localizedDescription: "Some arguments are missing or wrong")
        completion(FlutterError(code: "\(missingArgsError.code)", message: missingArgsError.localizedDescription, details: missingArgsError.jsonDescription))
    }
    
    private func getArg<T: Decodable>(_ key: ArgKey, from arguments: Any?) -> T? {
        if let value = (arguments as? [String: Any])?[key.rawValue] {
            if T.self == Data.self {
                if let hex = value as? String {
                    return Data(hexString: hex) as? T
                } else {
                    return nil
                }
            } else {
                if let decoded: T = decodeObject(value) {
                    return decoded
                } else {
                    return value as? T
                }
            }
        } else {
            return nil
        }
    }
    
    private func decodeObject<T: Decodable>(_ value: Any) -> T? {
        if let json = value as? String, let jsonData = json.data(using: .utf8) {
            do {
                return try JSONDecoder.tangemSdkDecoder.decode(T.self, from: jsonData)
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    private enum ArgKey: String {
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
}

fileprivate extension TangemSdkError {
    func toPluginError() -> PluginError {
        return PluginError(code: self.code, localizedDescription: self.localizedDescription)
    }
}
