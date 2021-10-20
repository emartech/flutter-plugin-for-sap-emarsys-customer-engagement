//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackTagCommandTests: XCTestCase {
var command: EmarsysCommandProtocol!

override func setUpWithError() throws {
    command = TrackTagCommand()
}

func testExecute_returnError_whenEventNameIsInvalid() throws {
    let expectedResponse = ["error": "Invalid eventName argument"]
    var result = [String: Any]()

    command.execute(arguments: ["attributes":[:]]) { response in
        result = response
    }

    XCTAssertEqual(result as? [String: String], expectedResponse)
}

func testExecute_returnError_whenAttributesIsInvalid() throws {
    let expectedResponse = ["error": "Invalid attributes argument"]
    var result = [String: Any]()
    command.execute(arguments: ["eventName":"testData"]) { response in
        result = response
    }

    XCTAssertEqual(result as? [String: String], expectedResponse)
}
}
