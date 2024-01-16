//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackCategoryCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackCategoryCommand()
    }
        
    func testExecute_returnError_whenCategoryPathIsInvalid() throws {
        let expectedResponse = ["error": "Invalid categoryPath argument"]
        var result = [String: Any]()

        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
