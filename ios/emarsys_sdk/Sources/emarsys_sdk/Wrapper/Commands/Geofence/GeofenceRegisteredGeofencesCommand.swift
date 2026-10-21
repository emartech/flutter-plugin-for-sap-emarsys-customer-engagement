//
//  Created by Emarsys on 2021. 11. 02.
//

import EmarsysSDK

class GeofenceRegisteredGeofencesCommand: EmarsysCommandProtocol {
    
    var geofencesMapper: GeofencesMapper
    
    init(geofencesMapper: GeofencesMapper) {
        self.geofencesMapper = geofencesMapper
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        let geofences = Emarsys.geofence.registeredGeofences()
        resultCallback(["success":geofencesMapper.map(geofences)])
    }
    
}
