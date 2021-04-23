//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class SetContactCommand: EmarsysCommandProtocol {

    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        if let contactFieldValue = arguments?["contactFieldValue"] as? String {
            Emarsys.setContactWithContactFieldValue(contactFieldValue) { error in
                if let e = error {
                    resultCallback(["error": e])
                } else {
                    resultCallback(["success": true])
                }
            }
        } else {
            resultCallback(["error": "Invalid contactFieldValue"])
        }
    }

}
