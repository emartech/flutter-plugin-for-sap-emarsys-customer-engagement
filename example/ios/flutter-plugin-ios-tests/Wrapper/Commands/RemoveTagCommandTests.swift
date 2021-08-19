//
//  Created by Emarsys on 2021. 08. 19..
//

import XCTest
@testable import emarsys_sdk

class RemoveTagCommandTests: XCTestCase {

    var command: RemoveTagCommand!
    
    override func setUpWithError() throws {
        command = RemoveTagCommand()
    }

    func testExecute_returnError_whenTagIsInvalid() throws {
        let arguments = ["messageId": "testMessageId"]
        let expectedResponse = ["error": "Invalid tag"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

    func testExecute_returnError_whenMessageIdIsInvalid() throws {
        let arguments = ["tag": "testTag"]
        let expectedResponse = ["error": "Invalid messageId"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
}
