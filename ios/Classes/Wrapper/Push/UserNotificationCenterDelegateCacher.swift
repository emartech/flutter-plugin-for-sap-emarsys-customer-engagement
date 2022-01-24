import Foundation
import UserNotifications

public class UserNotificationCenterDelegateCacher: NSObject, UNUserNotificationCenterDelegate {
    
    private var didReceiveCache = [[String: Any]]()
    private var willPresentCache = [[String: Any]]()
    private var openSettingsCache = [[String: Any]]()
    
    static let instance = UserNotificationCenterDelegateCacher()
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        didReceiveCache.append([
            "center": center,
            "response": response,
            "completionHandler": completionHandler])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        willPresentCache.append([
            "center": center,
            "notification": notification,
            "completionHandler": completionHandler])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        var dict = [String: Any]()
        dict["center"] =  center
        if let noti = notification {
            dict["notification"] = noti
        }
        openSettingsCache.append(dict)
    }
    
    func emptyCache(with notificationCenterDeleagte: UNUserNotificationCenterDelegate) {
        willPresentCache.forEach { cachedDict in
            notificationCenterDeleagte.userNotificationCenter?(cachedDict["center"] as! UNUserNotificationCenter, willPresent: cachedDict["notification"] as! UNNotification, withCompletionHandler: cachedDict["completionHandler"] as! (UNNotificationPresentationOptions) -> Void)
        }
        didReceiveCache.forEach { cachedDict in
            notificationCenterDeleagte.userNotificationCenter?(cachedDict["center"] as! UNUserNotificationCenter, didReceive: cachedDict["response"] as! UNNotificationResponse, withCompletionHandler: cachedDict["completionHandler"] as! () -> Void)
        }
        if #available(iOS 12.0, *) {
            openSettingsCache.forEach { cachedDict in
                var notification: UNNotification? = nil
                if let noti = cachedDict["notification"] as? UNNotification {
                    notification = noti
                }
                notificationCenterDeleagte.userNotificationCenter?(cachedDict["center"] as! UNUserNotificationCenter, openSettingsFor: notification)
            }
            openSettingsCache.removeAll()
        }
        willPresentCache.removeAll()
        didReceiveCache.removeAll()
    }
    
}
