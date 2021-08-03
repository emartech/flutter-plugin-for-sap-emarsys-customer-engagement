//
//  Created by Emarsys on 2021.
//

import Foundation
import EmarsysSDK

class EmarsysStreamHandler: NSObject, FlutterStreamHandler {
    
    var sink: FlutterEventSink?
    var eventHandler: EMSEventHandlerBlock?
    
    override init() {
        super.init()
        self.eventHandler = { [unowned self] eventName, payload in
            var event = [String: Any]()
            event["name"] = eventName
            event["payload"] = payload
            self.sink?(event)
        }
    }
        
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
