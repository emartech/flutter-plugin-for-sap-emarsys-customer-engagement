//
//  Created by Emarsys on 2021. 08. 25..
//

import Foundation
import EmarsysSDK

class GeofenceiOSRequestAlwaysAuthorizationCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.geofence.requestAlwaysAuthorization()
        resultCallback(["success": true])
    }
}
