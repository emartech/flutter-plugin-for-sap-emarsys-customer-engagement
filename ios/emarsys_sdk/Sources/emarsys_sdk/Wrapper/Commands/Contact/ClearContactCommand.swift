//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

public class ClearContactCommand: EmarsysCommandProtocol {

    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.clearContact() { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                resultCallback(["success": true])
            }
        }
    }

}
