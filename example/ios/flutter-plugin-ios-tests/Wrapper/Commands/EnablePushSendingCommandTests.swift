//
//  Created by Emarsys on 2021. 05. 04..
//

import XCTest
@testable import emarsys_sdk

class EnablePushSendingCommandTests: XCTestCase {

    var command: EnablePushSendingCommand?
    
    override func setUpWithError() throws {
        command = EnablePushSendingCommand()
    }
    
    func testExecute_returnError_missingArgument() throws {
        let arguments = [String: Any]()
        let expectedResponse = ["error": "Invalid enablePushSending argument"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }

    func testExecute_returnError_missingPushToken() throws {
        EmarsysPushTokenHolder.pushToken = nil
        
        let arguments = ["enablePushSending": true]
        let expectedResponse = ["error": "Push token is not available"]
        var result = [String: Any]()

        command?.execute(arguments: arguments) { response in
            result = response
        }

        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
}
