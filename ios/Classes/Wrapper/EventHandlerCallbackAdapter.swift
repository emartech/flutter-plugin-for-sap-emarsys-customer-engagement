//
//  Created by Emarsys on 2021.
//

import EmarsysSDK

class EventHandlerCallbackAdapter: NSObject, EMSEventHandler {

    private var callback: EventCallback
    
    init(callback: @escaping EventCallback) {
        self.callback = callback
    }
    
    func handleEvent(_ eventName: String, payload: [String : NSObject]?) {
        self.callback(eventName, payload)
    }
}
