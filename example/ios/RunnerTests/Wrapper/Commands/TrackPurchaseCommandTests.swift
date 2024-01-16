//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class TrackPurchaseCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackPurchaseCommand()
    }

    func testExecute_returnError_whenOrderIdIsInvalid() throws {
        let expectedResponse = ["error": "Invalid orderId argument"]
        var result = [String: Any]()

        command.execute(arguments: ["items": []]) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

    func testExecute_returnError_whenItemsIsInvalid() throws {
        let expectedResponse = ["error": "Invalid items argument"]
        var result = [String: Any]()

        command.execute(arguments: ["orderId": "testData"]) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
