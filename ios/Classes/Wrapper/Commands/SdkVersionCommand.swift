//
// Created by Emarsys on 2021.
//
import EmarsysSDK

class SdkVersionCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success": Emarsys.config.sdkVersion()])
    }
}
