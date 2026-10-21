//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class SetContactCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        if let contactFieldValue = arguments?["contactFieldValue"] as? String {
            if let contactFieldId = arguments?["contactFieldId"] as? Int {
                Emarsys.setContact(contactFieldId: NSNumber(integerLiteral: contactFieldId), contactFieldValue: contactFieldValue) { error in
                    if let e = error {
                        resultCallback(["error": e])
                    } else {
                        resultCallback(["success": true])
                    }
                }
            } else {
                resultCallback(["error": "Invalid contactFieldId"])
            }
        } else {
            resultCallback(["error": "Invalid contactFieldValue"])
        }
    }
    
}
