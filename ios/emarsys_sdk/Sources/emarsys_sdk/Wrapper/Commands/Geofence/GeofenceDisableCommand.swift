//
//  Created by Emarsys on 2021. 08. 25..
//

import Foundation
import EmarsysSDK

class GeofenceDisableCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.geofence.disable()
        resultCallback(["success": true])
    }
}
