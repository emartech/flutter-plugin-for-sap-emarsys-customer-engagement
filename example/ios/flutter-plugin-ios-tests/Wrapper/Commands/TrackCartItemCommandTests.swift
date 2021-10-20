//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackCartItemCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackCartItemCommand()
    }
    
    func testExecute_returnError_whenItemsIsInvalid() throws {
        let expectedResponse = ["error": "Invalid items argument"]
        var result = [String: Any]()
        
        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
