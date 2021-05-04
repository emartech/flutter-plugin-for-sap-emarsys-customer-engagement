//
//  Created by Emarsys on 2021. 04. 22..
//

import XCTest
@testable import emarsys_sdk

class EmarsysCommandFactoryTests: XCTestCase {

    var factory: EmarsysCommandFactory?

    override func setUpWithError() throws {
        factory = EmarsysCommandFactory()
    }

    func testCreate_setup() throws {
        let command = factory?.create(name: "setup")
        
        XCTAssertTrue(command is SetupCommand)
    }

    func testCreate_setContact() throws {
        let command = factory?.create(name: "setContact")

        XCTAssertTrue(command is SetContactCommand)
    }

    func testCreate_clearContact() throws {
        let command = factory?.create(name: "clearContact")

        XCTAssertTrue(command is ClearContactCommand)
    }
    
    func testCreate_returnNilWhenInvalid() throws {
        let command = factory?.create(name: "invalidCommandNameTest")

        XCTAssertNil(command)
    }
    
    func testCreate_enablePushSending() throws {
        let command = factory?.create(name: "enablePushSending")

        XCTAssertTrue(command is EnablePushSendingCommand)
    }

}
