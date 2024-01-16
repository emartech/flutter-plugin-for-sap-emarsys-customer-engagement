//
//  Created by Emarsys on 2021. 08. 11..
//

import XCTest
@testable import emarsys_sdk

class TrackCustomEventCommandTests: XCTestCase {

    var command: TrackCustomEventCommand!

    override func setUpWithError() throws {
        command = TrackCustomEventCommand()
    }

    func testExecute_returnError_whenEventNameIsInvalid() throws {
        let expectedResponse = ["error": "Invalid eventName"]
        var result = [String: Any]()

        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

}
