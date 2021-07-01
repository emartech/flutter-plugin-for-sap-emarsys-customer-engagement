//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class SetupCommand: EmarsysCommandProtocol {
    private var pushEventHandler: EMSEventHandler
    private var silentPushEventHandler: EMSEventHandler
    
    init(pushEventHandler: EMSEventHandler, silentPushEventHandler: EMSEventHandler) {
        self.pushEventHandler = pushEventHandler
        self.silentPushEventHandler = silentPushEventHandler
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        var error: [String : String]? = nil
        
        guard let contactFieldId = arguments?["contactFieldId"] as? NSNumber else {
            resultCallback(["error": "Invalid parameter: contactFieldId"])
            return
        }
        let config = EMSConfig.make(builder: { builder in
            builder.setContactFieldId(contactFieldId)
            if let applicationCode = arguments?["applicationCode"] as? String {
                builder.setMobileEngageApplicationCode(applicationCode)
            }
            if let merchantId = arguments?["merchantId"] as? String {
                builder.setMerchantId(merchantId)
            }
            if let enabledConsoleLogLevels = arguments?["iOSEnabledConsoleLogLevels"] as? Array<String> {
                var logLevels = [EMSLogLevelProtocol?]()
                logLevels = enabledConsoleLogLevels.map {
                    switch $0 {
                    case EMSLogLevel.basic.level():
                        return   EMSLogLevel.basic
                    case EMSLogLevel.debug.level():
                        return   EMSLogLevel.debug
                    case EMSLogLevel.error.level():
                        return    EMSLogLevel.error
                    case EMSLogLevel.info.level():
                        return   EMSLogLevel.info
                    case EMSLogLevel.trace.level():
                        return    EMSLogLevel.trace
                    case EMSLogLevel.warn.level():
                        return     EMSLogLevel.warn
                    default:
                        error = ["error": "Invalid logLevel: \($0)"]
                        return nil
                    }
                }.filter {$0 != nil}
                builder.enableConsoleLogLevels(logLevels as! [EMSLogLevelProtocol])
            }
            if let sharedKeychainAccessGroup = arguments?["iOSSharedKeychainAccessGroup"] as? String {
                builder.setSharedKeychainAccessGroup(sharedKeychainAccessGroup)
            }
        })
        if let e = error {
            resultCallback(e)
        } else {
            Emarsys.setup(with: config)
            if (EmarsysPushTokenHolder.enabled) {
                if (EmarsysPushTokenHolder.pushToken != nil) {
                    Emarsys.push.setPushToken(EmarsysPushTokenHolder.pushToken!)
                } else {
                    EmarsysPushTokenHolder.pushTokenObserver = { pushToken in
                        if pushToken != nil {
                            Emarsys.push.setPushToken(pushToken!)
                        }
                    }
                }
            }
            UNUserNotificationCenter.current().delegate = Emarsys.notificationCenterDelegate
            
            Emarsys.push.silentMessageEventHandler = self.silentPushEventHandler
            Emarsys.notificationCenterDelegate.eventHandler = self.pushEventHandler
            
            Emarsys.trackCustomEvent(withName: "wrapper:init", eventAttributes: ["type" : "flutter"])
            resultCallback(["success": true])
        }
    }
}
