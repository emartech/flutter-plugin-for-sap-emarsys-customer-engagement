//
// Created by Emarsys on 2021. 05. 04..
//
import EmarsysSDK

public class PushSendingEnabledCommand: EmarsysCommandProtocol {

    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let enable = arguments?["pushSendingEnabled"] as? Bool else {
            resultCallback(["error": "Invalid pushSendingEnabled argument"])
            return
        }
        EmarsysPushTokenHolder.enabled = enable
        if enable {
            if let token = EmarsysPushTokenHolder.pushToken {
                Emarsys.push.setPushToken(pushToken: token) { error in
                    if let e = error {
                        resultCallback(["error": e])
                    } else {
                        resultCallback(["success": true])
                    }
                }
            } else {
                resultCallback(["error": "Push token is not available"])
            }
        } else {
            Emarsys.push.clearPushToken() { error in
                if let e = error {
                    resultCallback(["error": e])
                } else {
                    resultCallback(["success": true])
                }
            }
        }
    }

}
