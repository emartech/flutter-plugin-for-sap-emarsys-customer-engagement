//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk

class ChangeMerchantIdTests: XCTestCase {


    var command: ChangeMerchantIdCommand!
    
    override func setUpWithError() throws {
        command = ChangeMerchantIdCommand()
    }
    
    func testExecute_returnError_whenMerchantIdIsInvalid() throws {
        let expectedResponse = ["error": "Invalid merchantId"]
        var result = [String: Any]()

        command.execute(arguments: nil) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

}
