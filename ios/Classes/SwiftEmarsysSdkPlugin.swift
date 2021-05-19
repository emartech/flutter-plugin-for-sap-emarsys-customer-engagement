import Flutter
import UIKit

public class SwiftEmarsysSdkPlugin: NSObject, FlutterPlugin {
    
    static var factory: EmarsysCommandFactory?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.emarsys.methods", binaryMessenger: registrar.messenger())
    let pushEventChannel = FlutterEventChannel(name: "com.emarsys.events.push", binaryMessenger: registrar.messenger())
    let silentPushEventChannel = FlutterEventChannel(name: "com.emarsys.events.silentPush", binaryMessenger: registrar.messenger())
    
    let pushEventCallback: EventCallback = createEventCallback(eventChannel: pushEventChannel)
    let silentPushEventCallback: EventCallback = createEventCallback(eventChannel: silentPushEventChannel)
    
    factory = EmarsysCommandFactory(pushEventCallback: pushEventCallback, silentPushEventCallback: silentPushEventCallback)
    
    let instance = SwiftEmarsysSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    private static func createEventCallback(eventChannel: FlutterEventChannel) -> EventCallback {
        return { name, payload in
            eventChannel.setStreamHandler(EmarsysStreamHandler() { eventSink in
                var event = [String: Any]()
                event["name"] = name
                event["payload"] = payload
                eventSink(event)
            })
        }
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
