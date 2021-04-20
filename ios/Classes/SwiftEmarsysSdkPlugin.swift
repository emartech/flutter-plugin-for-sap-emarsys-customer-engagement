import Flutter
import UIKit

public class SwiftEmarsysSdkPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.emarsys.methods", binaryMessenger: registrar.messenger())
    let instance = SwiftEmarsysSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result()
  }
}
