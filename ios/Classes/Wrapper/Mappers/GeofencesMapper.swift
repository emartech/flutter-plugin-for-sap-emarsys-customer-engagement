//
//  GeofenceMapper.swift
//  emarsys_sdk
//

import Foundation
import EmarsysSDK

class GeofencesMapper: Mappable {
    
    typealias Input = [EMSGeofence]
    typealias Output = [[String: Any]]
    
    func map(_ input: [EMSGeofence]) -> [[String : Any]] {
        input.map{
            $0.toMap()
        }
    }
}

extension EMSGeofence {
    func toMap() -> [String: Any] {
        [
            "id": id as String,
            "lat": lat as Double,
            "lon": lon as Double,
            "radius": r as Int32,
            "waitInterval": waitInterval as Double,
            "triggers": triggers.map{$0.toMap()}
         ]
    }
}

extension EMSGeofenceTrigger {
    func toMap() -> [String: Any?] {
        [
            "id": id,
            "type": type,
            "loiteringDelay": loiteringDelay,
            "action": action
        ]
    }
}
