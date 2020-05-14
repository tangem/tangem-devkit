import Flutter
import UIKit
import TangemSdk

public class SwiftTangemsdkPlugin: NSObject, FlutterPlugin {
    private lazy var sdk: TangemSdk = {
        return TangemSdk()
    }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tangemSdk", binaryMessenger: registrar.messenger())
        let instance = SwiftTangemsdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "scanCard":
            scanCard(result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func scanCard(_ completion: @escaping FlutterResult) {
        sdk.scanCard { [weak self] scanResult in
            self?.handleCompletion(scanResult, completion)
        }
    }
    
    private func handleCompletion<TResult: TlvCodable>(_ sdkResult: Result<TResult, SessionError>, _ completion: @escaping FlutterResult) {
        switch sdkResult {
        case .success(let response):
            completion(response.description)
        case .failure(let error):
            completion(FlutterError(code: error.localizedDescription, message: String(describing: error), details: nil))
        }
    }
}
