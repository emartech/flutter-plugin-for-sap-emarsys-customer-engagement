//
//  Created by Emarsys on 2021. 08. 10..
//
import EmarsysSDK

class ChangeApplicationCodeCommand: EmarsysCommandProtocol {
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
        guard let applicationCode = arguments?["applicationCode"] as? String else {
            resultCallback(["error": "Invalid applicationCode"])
            return
        }
        Emarsys.config.changeApplicationCode(applicationCode: applicationCode) { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                Emarsys.push.silentMessageEventHandler = self.silentPushEventHandler
                Emarsys.push.notificationEventHandler = self.pushEventHandler
                Emarsys.geofence.eventHandler = self.geofenceEventHandler
                Emarsys.inApp.eventHandler = self.inAppEventHandler
                
                resultCallback(["success": true])
            }
        }
    }
}
