//
// Created by Emarsys on 2021.
//
import EmarsysSDK

class PushSettingsCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success": Emarsys.config.pushSettings()])
    }
}
