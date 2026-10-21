//
//  Created by Emarsys
//
import EmarsysSDK

public class InAppIsPausedCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success": Emarsys.inApp.isPaused()]);
    }
}
