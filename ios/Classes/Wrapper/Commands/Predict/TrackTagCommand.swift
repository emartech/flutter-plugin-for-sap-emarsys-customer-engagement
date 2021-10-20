//
// Created by Emarsys
//

import EmarsysSDK

class TrackTagCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let eventName = arguments?["eventName"] as? String else {
            resultCallback(["error": "Invalid eventName argument"])
            return
        }
        guard let attributes = arguments?["attributes"] as? Dictionary<String, String> else {
            resultCallback(["error": "Invalid attributes argument"])
            return
        }

        Emarsys.predict.trackTag(tag: eventName,attributes: attributes)

        resultCallback(["success": true])
    }
}
