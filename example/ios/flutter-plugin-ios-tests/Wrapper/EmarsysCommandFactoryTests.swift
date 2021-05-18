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
        let command = factory?.create(name: "push.enablePushSending")

        XCTAssertTrue(command is PushSendingEnabledCommand)
    }
    
    func testCreate_applicationCodeCommand() throws {
        let command = factory?.create(name: "config.applicationCode")

        XCTAssertTrue(command is ApplicationCodeCommand)
    }
    
    func testCreate_merchantIdCommand() throws {
        let command = factory?.create(name: "config.merchantId")

        XCTAssertTrue(command is MerchantIdCommand)
    }
    
    func testCreate_contactFieldIdCommand() throws {
        let command = factory?.create(name: "config.contactFieldId")

        XCTAssertTrue(command is ContactFieldIdCommand)
    }
    
    func testCreate_hardwareIdCommand() throws {
        let command = factory?.create(name: "config.hardwareId")

        XCTAssertTrue(command is HardwareIdCommand)
    }
    
    func testCreate_languageCodeCommand() throws {
        let command = factory?.create(name: "config.languageCode")

        XCTAssertTrue(command is LanguageCodeCommand)
    }
    
    func testCreate_pushSettingsCommand() throws {
        let command = factory?.create(name: "config.pushSettings")

        XCTAssertTrue(command is PushSettingsCommand)
    }
    
    func testCreate_sdkVersionCommand() throws {
        let command = factory?.create(name: "config.sdkVersion")

        XCTAssertTrue(command is SdkVersionCommand)
    }
}

