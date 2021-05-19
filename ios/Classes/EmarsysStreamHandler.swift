//
//  Created by Emarsys on 2021.
//

import Foundation

class EmarsysStreamHandler: NSObject, FlutterStreamHandler {
    
    var onListenCallback: (_ eventSink: @escaping FlutterEventSink) -> ()
    
    init(onListenCallback: @escaping (_ eventSink: @escaping FlutterEventSink) -> ()) {
        self.onListenCallback = onListenCallback
    }
        
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        onListenCallback(events)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
