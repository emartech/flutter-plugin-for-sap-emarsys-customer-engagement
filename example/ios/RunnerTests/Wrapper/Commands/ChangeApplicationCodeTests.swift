//
//  Created by Emarsys on 2021. 08. 10..
//

import XCTest
@testable import emarsys_sdk

class ChangeApplicationCodeTests: XCTestCase {

    var command: ChangeApplicationCodeCommand!
    
    override func setUpWithError() throws {
        command = ChangeApplicationCodeCommand(
            pushEventHandler: {name, payload in },
            silentPushEventHandler: {name, payload in },
            geofenceEventHandler: {name, payload in },
            inAppEventHandler: {name, payload in }
        )
    }
    
    func testExecute_returnError_whenApplicationCodeIsInvalid() throws {
        let expectedResponse = ["error": "Invalid applicationCode"]
        var result = [String: Any]()

        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

}
