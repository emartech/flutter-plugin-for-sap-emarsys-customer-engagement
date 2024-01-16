//
//  Created by Emarsys on 2021. 04. 22..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class SetupCommandTests: XCTestCase {

    var command: SetupCommand?
    
    override func setUpWithError() throws {
        command = SetupCommand(pushEventHandler: {name, payload in }, silentPushEventHandler: {name, payload in }, geofenceEventHandler: {name, payload in }, inAppEventHandler: {name, payload in})
    }
    
    func testExecute_returnTrue() throws {
        let arguments = ["contactFieldId": 3]
        let expectedResponse = ["success": true]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: Bool], expectedResponse)
    }
    
    func testExecute_returnError_logLevel() throws {
        let arguments = [
            "contactFieldId": 3,
            "iOSEnabledConsoleLogLevels": ["NotALogLevel"]
        ] as [String : Any]
        let expectedResponse = ["error": "Invalid logLevel: NotALogLevel"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
