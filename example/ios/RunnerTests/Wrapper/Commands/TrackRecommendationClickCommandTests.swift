//
// Created by Emarsys on 2021. 10. 26..
//

import XCTest
@testable import emarsys_sdk

class TrackRecommendationClickCommandTests: XCTestCase  {
    var command: EmarsysCommandProtocol!

    override func setUpWithError() throws {
        command = TrackRecommendationClickCommand(mapToProductMapper: MapToProductMapper())
    }

    func testExecute_returnError_whenProductIsInvalid() throws {
        let expectedResponse = ["error": "Invalid product argument"]
        var result = [String: Any]()

        command.execute(arguments: ["product":[]]) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
