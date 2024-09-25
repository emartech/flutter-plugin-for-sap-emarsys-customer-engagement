import UIKit
import Flutter
import emarsys_sdk

class CustomDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter: didReceive: withCompletionHandler:")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter: willPresent: withCompletionHandler:")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("userNotificationCenter: openSettingsFor:")
    }
    
}

@main
@objc class AppDelegate: EmarsysAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let result =  super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return result
    }
    
    override func notificationCenterDelegateDataSource() -> [UNUserNotificationCenterDelegate] {
        let customDelegate = CustomDelegate()
        let customDelegate2 = CustomDelegate()
        return [customDelegate, customDelegate2]
    }
    
}
