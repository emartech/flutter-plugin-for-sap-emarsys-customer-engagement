//
//  SetPushNotificationCommand.swift
//  emarsys_sdk
//
//  Created by Vinicius Luciano on 04/11/22.
//
import EmarsysSDK

public class SetPushTokenCommand: EmarsysCommandProtocol {

    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let newPushToken = arguments?["pushToken"] as? String else {
            resultCallback(["error": "Invalid pushToken argument"])
            return
        }

        let newPushTokenData = Data(newPushToken.utf8)

        if let token = EmarsysPushTokenHolder.pushToken {
            if token != newPushTokenData {
                EmarsysPushTokenHolder.pushToken = newPushTokenData
                Emarsys.push.setPushToken(pushToken: newPushTokenData) { error in
                    if let e = error {
                        resultCallback(["error": e])
                    } else {
                        resultCallback(["success": true])
                    }
                }
            }
        } else {
            resultCallback(["error": "Push token is not available"])
        }
    }

}