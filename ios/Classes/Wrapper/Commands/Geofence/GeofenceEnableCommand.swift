//
//  Created by Emarsys on 2021. 08. 25..
//

import Foundation
import EmarsysSDK

class GeofenceEnableCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.geofence.enable()
        resultCallback(["success": true])
    }
}
