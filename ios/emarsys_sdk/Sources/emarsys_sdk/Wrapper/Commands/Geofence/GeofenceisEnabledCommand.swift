//
//  Created by Emarsys on 2021. 08. 25..
//

import EmarsysSDK

class GeofenceisEnabledCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success":Emarsys.geofence.isEnabled()])
    }
    
}
