//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class SetupCommand: EmarsysCommandProtocol {
    private var pushEventCallback: EventCallback
    private var silentPushEventCallback: EventCallback
    
    init(pushEventCallback: @escaping EventCallback, silentPushEventCallback: @escaping EventCallback) {
        self.pushEventCallback = pushEventCallback
        self.silentPushEventCallback = silentPushEventCallback
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
            UNUserNotificationCenter.current().delegate = Emarsys.notificationCenterDelegate
            
            Emarsys.push.silentMessageEventHandler = EventHandlerCallbackAdapter(callback: silentPushEventCallback)
            Emarsys.notificationCenterDelegate.eventHandler = EventHandlerCallbackAdapter(callback: pushEventCallback)
            
            resultCallback(["success": true])
        }
    }
}
