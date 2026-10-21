//
// Created by Emarsys
//

import EmarsysSDK

class TrackSearchTermCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let searchTerm = arguments?["searchTerm"] as? String else {
            resultCallback(["error": "Invalid searchTerm argument"])
            return
        }
        
        Emarsys.predict.trackSearch(searchTerm: searchTerm)

        resultCallback(["success": true])
    }
}
