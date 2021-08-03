//
//  Created by Emarsys on 2021. 04. 22..
//

import XCTest
@testable import emarsys_sdk

class SetContactCommandTests: XCTestCase {

    var command: SetContactCommand?
    
    override func setUpWithError() throws {
        command = SetContactCommand()
    }
    
    func testExecute_returnError_whenContactFieldValueIsInvalid() throws {
        let arguments = ["contactFieldValue": 123]
        let expectedResponse = ["error": "Invalid contactFieldValue"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
    func testExecute_returnError_whenContactFieldIdIsInvalid() throws {
        let arguments = ["contactFieldValue": "test",
                         "contactFieldId": "id"]
        let expectedResponse = ["error": "Invalid contactFieldId"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

}
