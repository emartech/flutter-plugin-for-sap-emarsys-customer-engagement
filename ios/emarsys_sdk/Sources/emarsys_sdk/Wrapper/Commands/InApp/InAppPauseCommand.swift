//
//  Created by Emarsys
//
import EmarsysSDK

public class InAppPauseCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.inApp.pause()
        resultCallback(["success": true])
    }
}
