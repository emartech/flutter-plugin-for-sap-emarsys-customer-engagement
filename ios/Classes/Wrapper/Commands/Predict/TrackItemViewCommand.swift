//
// Created by Emarsys
//

import EmarsysSDK

class TrackItemViewCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let itemView = arguments?["itemView"] as? String else {
            resultCallback(["error": "Invalid itemView argument"])
            return
        }
        
        Emarsys.predict.trackItem(itemId : itemView)

        resultCallback(["success": true])
    }
}
