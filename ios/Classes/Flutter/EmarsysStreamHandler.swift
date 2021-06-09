//
//  Created by Emarsys on 2021.
//

import Foundation
import EmarsysSDK

class EmarsysStreamHandler: NSObject, FlutterStreamHandler, EMSEventHandler {
    
    var sink: FlutterEventSink?
        
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    func handleEvent(_ eventName: String, payload: [String : NSObject]?) {
        var event = [String: Any]()
        event["name"] = eventName
        event["payload"] = payload
        self.sink?(event)
    }
}
