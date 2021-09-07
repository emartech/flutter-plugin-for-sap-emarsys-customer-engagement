import Flutter
import UIKit

public class SwiftEmarsysSdkPlugin: NSObject, FlutterPlugin {
    
    static var factory: EmarsysCommandFactory?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.emarsys.methods", binaryMessenger: registrar.messenger())
    let pushEventChannel = FlutterEventChannel(name: "com.emarsys.events.push", binaryMessenger: registrar.messenger())
    let silentPushEventChannel = FlutterEventChannel(name: "com.emarsys.events.silentPush", binaryMessenger: registrar.messenger())
    let geofenceEventChannel = FlutterEventChannel(name: "com.emarsys.events.geofence", binaryMessenger: registrar.messenger())
    let inAppEventChannel = FlutterEventChannel(name: "com.emarsys.events.inApp", binaryMessenger: registrar.messenger())
    
    let silentPushHandler = EmarsysStreamHandler()
    let pushHandler = EmarsysStreamHandler()
    let geofenceHandler = EmarsysStreamHandler()
    let inAppHandler = EmarsysStreamHandler()
    
    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "EmarsysSDKWrapperCheckerNotification"), object: nil, queue: nil) { (notification) in
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EmarsysSDKWrapperExist"), object: "flutter")
    }
    
    factory = EmarsysCommandFactory(pushEventHandler: pushHandler.eventHandler!,
                                    silentPushEventHandler: silentPushHandler.eventHandler!,
                                    inboxMapper: InboxMapper(),
                                    geofenceEventHandler: geofenceHandler.eventHandler!,
                                    inAppEventHandler: inAppHandler.eventHandler!)
    
    pushEventChannel.setStreamHandler(pushHandler)
    silentPushEventChannel.setStreamHandler(silentPushHandler)
    geofenceEventChannel.setStreamHandler(geofenceHandler)
    inAppEventChannel.setStreamHandler(inAppHandler)
    
    let instance = SwiftEmarsysSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let command = SwiftEmarsysSdkPlugin.factory?.create(name: call.method) else {
        let flutterError = FlutterError(code: "1501", message: "Command creation failed", details: nil)
        result(flutterError)
        return
    }
    command.execute(arguments: call.arguments as! [String: Any]?) { dict in
        if let error = dict["error"] as? String {
            let flutterError = FlutterError(code: "1501", message: error, details: nil)
            result(flutterError)
        } else if let error = dict["error"] as? NSError {
            let flutterError = FlutterError(code: "\(error.code)", message: error.localizedDescription, details: error.userInfo.description)
            result(flutterError)
        } else if let value = dict["success"] {
            result(value)
        }
    }
    
  }
}
