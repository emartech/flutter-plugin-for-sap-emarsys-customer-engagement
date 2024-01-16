//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackSearchTermCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackSearchTermCommand()
    }
    
    func testExecute_returnError_whenSearchTermIsInvalid() throws {
        let expectedResponse = ["error": "Invalid searchTerm argument"]
        var result = [String: Any]()
        
        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
