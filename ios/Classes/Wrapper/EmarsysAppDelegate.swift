import UIKit
import Flutter
import EmarsysSDK

@UIApplicationMain
@objc open class EmarsysAppDelegate: FlutterAppDelegate {
  
    open override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        var authorizationOptions: UNAuthorizationOptions = [.sound, .alert, .badge]
        if #available(iOS 12.0, *) {
            authorizationOptions = [.sound, .alert, .badge, .provisional]
        }
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { granted, error in
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    open override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        EmarsysPushTokenHolder.pushToken = deviceToken
    }
}
