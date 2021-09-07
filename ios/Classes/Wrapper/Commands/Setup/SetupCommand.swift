//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class SetupCommand: EmarsysCommandProtocol {
    private var pushEventHandler: EMSEventHandlerBlock
    private var silentPushEventHandler: EMSEventHandlerBlock
    private var geofenceEventHandler: EMSEventHandlerBlock
    private var inAppEventHandler: EMSEventHandlerBlock
    
    init(pushEventHandler: @escaping EMSEventHandlerBlock,
         silentPushEventHandler: @escaping EMSEventHandlerBlock,
         geofenceEventHandler: @escaping EMSEventHandlerBlock,
         inAppEventHandler: @escaping EMSEventHandlerBlock) {
        self.pushEventHandler = pushEventHandler
        self.silentPushEventHandler = silentPushEventHandler
        self.geofenceEventHandler = geofenceEventHandler
        self.inAppEventHandler = inAppEventHandler
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        var error: [String : String]? = nil
        
        let config = EMSConfig.make(builder: { builder in
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
            Emarsys.setup(config: config)
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
            UNUserNotificationCenter.current().delegate = Emarsys.push
            
            Emarsys.push.silentMessageEventHandler = self.silentPushEventHandler
            Emarsys.push.notificationEventHandler = self.pushEventHandler
            Emarsys.geofence.eventHandler = self.geofenceEventHandler
            Emarsys.inApp.eventHandler = self.inAppEventHandler
            
            Emarsys.trackCustomEvent(eventName: "wrapper:init", eventAttributes: ["type" : "flutter"])
            resultCallback(["success": true])
        }
    }
}
