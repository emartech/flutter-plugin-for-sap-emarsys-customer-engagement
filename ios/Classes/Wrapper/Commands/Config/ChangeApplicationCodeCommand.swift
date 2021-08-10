//
//  Created by Emarsys on 2021. 08. 10..
//
import EmarsysSDK

class ChangeApplicationCodeCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let applicationCode = arguments?["applicationCode"] as? String else {
            resultCallback(["error": "Invalid applicationCode"])
            return
        }
        Emarsys.config.changeApplicationCode(applicationCode: applicationCode) { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                resultCallback(["success": true])
            }
        }
    }
}
