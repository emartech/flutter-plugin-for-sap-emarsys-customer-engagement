//
// Created by Emarsys
//

import EmarsysSDK

class TrackItemViewCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let itemId = arguments?["itemId"] as? String else {
            resultCallback(["error": "Invalid itemId argument"])
            return
        }
        
        Emarsys.predict.trackItem(itemId : itemId)

        resultCallback(["success": true])
    }
}
