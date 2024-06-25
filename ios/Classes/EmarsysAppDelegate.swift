import UIKit
import Flutter
import EmarsysSDK

@objc open class EmarsysAppDelegate: FlutterAppDelegate {
  
    open override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        var authorizationOptions: UNAuthorizationOptions = [.sound, .alert, .badge]
        if #available(iOS 12.0, *) {
            authorizationOptions = [.sound, .alert, .badge, .provisional]
        }
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { granted, error in
        }
        UNUserNotificationCenter.current().delegate = UserNotificationCenterDelegateCacher.instance
        notificationCenterDelegateDataSource().forEach { UserNotificationCenterDelegateCacher.instance.addDelegate(notificationCenterDelegate: $0) }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    open override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        EmarsysPushTokenHolder.pushToken = deviceToken
    }
    
    open func notificationCenterDelegateDataSource() -> [UNUserNotificationCenterDelegate] {
        return []
    }
}
