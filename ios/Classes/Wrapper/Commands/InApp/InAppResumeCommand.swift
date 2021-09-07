//
//  Created by Emarsys
//
import EmarsysSDK

public class InAppResumeCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.inApp.resume()
        resultCallback(["success": true])
    }
}
