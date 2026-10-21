//
//  Created by Emarsys on 2021. 08. 25..
//

import Foundation
import EmarsysSDK

class GeofenceSetInitialEnterTriggerEnabledCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let enabled = arguments?["enabled"] as? Bool else {
            resultCallback(["error": "Invalid enabled parameter"])
            return
        }
        
        Emarsys.geofence.initialEnterTriggerEnabled = enabled
        resultCallback(["success": true])
    }
}
