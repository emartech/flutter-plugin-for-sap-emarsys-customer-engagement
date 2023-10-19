import Foundation
import UserNotifications

public class UserNotificationCenterDelegateCacher: NSObject, UNUserNotificationCenterDelegate {
    
    private var didReceiveCache = [[String: Any]]()
    private var willPresentCache = [[String: Any]]()
    private var openSettingsCache = [[String: Any]]()
    private var customDelegates = [any UNUserNotificationCenterDelegate]()
    private var emarsysNotificationCenterDelegate: UNUserNotificationCenterDelegate?
    private var caching = true
    
    public static let instance = UserNotificationCenterDelegateCacher()
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if caching {
            didReceiveCache.append([
                "center": center,
                "response": response,
                "completionHandler": completionHandler,
            ])
        }
        if isEmarsysNotification(notification: response.notification) {
            emarsysNotificationCenterDelegate?.userNotificationCenter?(
                center, didReceive: response, withCompletionHandler: completionHandler)
        } else {
            customDelegates.forEach { delegate in
                delegate.userNotificationCenter?(
                    center, didReceive: response, withCompletionHandler: completionHandler)
            }
        }
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter, willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if caching {
            willPresentCache.append([
                "center": center,
                "notification": notification,
                "completionHandler": completionHandler,
            ])
        }
        if isEmarsysNotification(notification: notification) {
            emarsysNotificationCenterDelegate?.userNotificationCenter?(
                center, willPresent: notification, withCompletionHandler: completionHandler)
        } else {
            customDelegates.forEach { delegate in
                delegate.userNotificationCenter?(
                    center, willPresent: notification, withCompletionHandler: completionHandler)
            }
        }
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?
    ) {
        if caching {
            var dict = [String: Any]()
            dict["center"] = center
            if let noti = notification {
                dict["notification"] = noti
            }
            openSettingsCache.append(dict)
        }
        if isEmarsysNotification(notification: notification) {
            if #available(iOS 12.0, *) {
                emarsysNotificationCenterDelegate?.userNotificationCenter?(center, openSettingsFor: notification)
            }
        } else {
            customDelegates.forEach { delegate in
                if #available(iOS 12.0, *) {
                    delegate.userNotificationCenter?(center, openSettingsFor: notification)
                }
            }
        }
    }
    
    public func addDelegate(notificationCenterDelegate: UNUserNotificationCenterDelegate) {
        self.customDelegates.append(notificationCenterDelegate)
    }
    
    func emptyCache(with notificationCenterDelegate: UNUserNotificationCenterDelegate) {
        self.emarsysNotificationCenterDelegate = notificationCenterDelegate
        willPresentCache.forEach { cachedDict in
            notificationCenterDelegate.userNotificationCenter?(
                cachedDict["center"] as! UNUserNotificationCenter,
                willPresent: cachedDict["notification"] as! UNNotification,
                withCompletionHandler: cachedDict["completionHandler"]
                as! (UNNotificationPresentationOptions) -> Void)
        }
        didReceiveCache.forEach { cachedDict in
            notificationCenterDelegate.userNotificationCenter?(
                cachedDict["center"] as! UNUserNotificationCenter,
                didReceive: cachedDict["response"] as! UNNotificationResponse,
                withCompletionHandler: cachedDict["completionHandler"] as! () -> Void)
        }
        if #available(iOS 12.0, *) {
            openSettingsCache.forEach { cachedDict in
                var notification: UNNotification? = nil
                if let noti = cachedDict["notification"] as? UNNotification {
                    notification = noti
                }
                notificationCenterDelegate.userNotificationCenter?(
                    cachedDict["center"] as! UNUserNotificationCenter, openSettingsFor: notification)
            }
            openSettingsCache.removeAll()
        }
        willPresentCache.removeAll()
        didReceiveCache.removeAll()
        self.caching = false
    }
    
    private func isEmarsysNotification(notification: UNNotification?) -> Bool {
        return ((notification?.request.content.userInfo.contains(where: { $0.key as! String == "ems"})) != nil)
    }
    
}
