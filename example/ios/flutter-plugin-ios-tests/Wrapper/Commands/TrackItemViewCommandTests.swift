//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackItemViewCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackItemViewCommand()
    }
    
    func testExecute_returnError_whenItemIdIsInvalid() throws {
        let expectedResponse = ["error": "Invalid itemId argument"]
        var result = [String: Any]()

        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
}
