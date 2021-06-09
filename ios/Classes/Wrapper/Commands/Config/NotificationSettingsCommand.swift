//
// Created by Emarsys on 2021.
//
import EmarsysSDK

class NotificationSettingsCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success": ["iOS" : Emarsys.config.pushSettings()]])
    }
}
