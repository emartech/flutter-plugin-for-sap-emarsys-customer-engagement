//
//  Created by Emarsys on 2021. 08. 11..
//
import EmarsysSDK

class TrackCustomEventCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let eventName = arguments?["eventName"] as? String else {
            resultCallback(["error": "Invalid eventName"])
            return
        }
        var eventAttributes: [String: String]? = nil
        if let attributes = arguments?["eventAttributes"] as? [String: String] {
            eventAttributes = attributes
        }
        Emarsys.trackCustomEvent(eventName: eventName, eventAttributes: eventAttributes) { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                resultCallback(["success": true])
            }
        }
    }
}
