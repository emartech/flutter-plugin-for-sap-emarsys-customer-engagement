//
//  GeofenceMapperTest.swift
//  flutter-plugin-ios-tests
//
//  Created by Sarro, Andras Gabor on 2021. 11. 03..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class GeofencesMapperTests: XCTestCase {
    
    var mapper: GeofencesMapper!
    
    override func setUp() {
        super.setUp()
        mapper = GeofencesMapper()
    }
    
    func testMap_withEmptyInput() throws {
        let expectation : [[String : Any]] = []
        let geofences : [EMSGeofence] = []
        
        let result : [[String : Any]] = self.mapper.map(geofences)
        
        XCTAssertEqual(NSArray(array: result),
                       NSArray(array: expectation))
    }
    
    
    func testMap() throws {
        let actionDictionary: [String: Any] = [
            "id": "testId",
            "type": "MECustomEvent",
            "name": "testName",
            "payload": ["key": "value"]
        ]
        
        let geofence1 = EMSGeofence(
            id: "testGeofenceId",
            lat: 12.34,
            lon: 56.78,
            r: 30,
            waitInterval: 90.12,
            triggers: [
                EMSGeofenceTrigger(
                    id: "testTriggerId",
                    type: "ENTER",
                    loiteringDelay: 123,
                    action: actionDictionary
                )
            ]
        )
        
        let geofence2 = EMSGeofence(
            id: "testGeofenceId2",
            lat: 12.34,
            lon: 56.78,
            r: 30,
            waitInterval: 90.12,
            triggers: [
                EMSGeofenceTrigger(
                    id: "testTriggerId2",
                    type: "EXIT",
                    loiteringDelay: 456,
                    action: [String: Any]()
                )
            ]
        )
        
        let expectedResult = [
            [
                "id": "testGeofenceId",
                "lat": 12.34,
                "lon": 56.78,
                "radius": 30.0,
                "waitInterval": 90.12,
                "triggers": [
                    [
                        "id": "testTriggerId",
                        "type": "ENTER",
                        "loiteringDelay": 123 as Int32,
                        "action": actionDictionary
                    ]
                ]
            ],
            [
                "id": "testGeofenceId2",
                "lat": 12.34,
                "lon": 56.78,
                "radius": 30.0,
                "waitInterval": 90.12,
                "triggers": [
                    [
                        "id": "testTriggerId2",
                        "type": "EXIT",
                        "loiteringDelay": 456 as Int32,
                        "action": [String: Any]()
                    ]
                ]
            ]
        ]
        
        let input = [geofence1!, geofence2!];
        let result = mapper.map(input)
        
        let resultTriggers1 = result[0]["triggers"] as! [[String: Any]]
        let expectedResultTrigger1 = expectedResult[0]["triggers"] as! [[String: Any]]
        let resultAction = resultTriggers1[0]["action"] as! [String: Any]
        
        XCTAssertEqual(result[0]["id"] as! String, expectedResult[0]["id"] as! String)
        XCTAssertEqual(result[0]["lat"] as! Double, expectedResult[0]["lat"] as! Double)
        XCTAssertEqual(result[0]["lon"] as! Double, expectedResult[0]["lon"] as! Double)
        XCTAssertEqual(result[0]["radius"] as! Double, expectedResult[0]["radius"] as! Double)
        XCTAssertEqual(result[0]["waitInterval"] as! Double, expectedResult[0]["waitInterval"] as! Double)
        XCTAssertEqual(resultTriggers1[0]["id"] as! String, expectedResultTrigger1[0]["id"] as! String)
        XCTAssertEqual(resultTriggers1[0]["type"] as! String, expectedResultTrigger1[0]["type"] as! String)
        XCTAssertEqual(resultTriggers1[0]["loiteringDelay"] as! Int32, expectedResultTrigger1[0]["loiteringDelay"] as! Int32)
        XCTAssertEqual(resultAction.keys.count, actionDictionary.keys.count)
        
        let resultTriggers2 = result[1]["triggers"] as! [[String: Any]]
        let expectedResultTrigger2 = expectedResult[1]["triggers"] as! [[String: Any]]
        let resultAction2 = resultTriggers2[0]["action"] as! [String: Any]
        
        XCTAssertEqual(result[1]["id"] as! String, expectedResult[1]["id"] as! String)
        XCTAssertEqual(result[1]["lat"] as! Double, expectedResult[1]["lat"] as! Double)
        XCTAssertEqual(result[1]["lon"] as! Double, expectedResult[1]["lon"] as! Double)
        XCTAssertEqual(result[1]["radius"] as! Double, expectedResult[1]["radius"] as! Double)
        XCTAssertEqual(result[1]["waitInterval"] as! Double, expectedResult[1]["waitInterval"] as! Double)
        XCTAssertEqual(resultTriggers2[0]["id"] as! String, expectedResultTrigger2[0]["id"] as! String)
        XCTAssertEqual(resultTriggers2[0]["type"] as! String, expectedResultTrigger2[0]["type"] as! String)
        XCTAssertEqual(resultTriggers2[0]["loiteringDelay"] as! Int32, expectedResultTrigger2[0]["loiteringDelay"] as! Int32)
        XCTAssertEqual(resultAction2.keys.count, 0)
    }
}
