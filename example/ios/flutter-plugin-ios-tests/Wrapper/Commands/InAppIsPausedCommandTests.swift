//
//  Created by Emarsys
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class InAppIsPausedCommandTests: XCTestCase {
    var command: InAppIsPausedCommand!
    
    override func setUp() {
        command = InAppIsPausedCommand()
    }
    
    func testExecute_returnSuccessTrue_WhenPaused() throws {
        Emarsys.setup(config: EMSConfig.make(builder: { builder in
            builder.setMobileEngageApplicationCode("EMS11-C3FD3")
        }))
        
        Emarsys.inApp.pause()
        
        let expectedResponse = ["success": true]
        var result = [String: Any]()
        
        command?.execute(arguments: [:]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: Bool], expectedResponse)
    }
    
    func testExecute_returnSuccessFalse_WhenNotPaused() throws {
        Emarsys.setup(config: EMSConfig.make(builder: { builder in
            builder.setMobileEngageApplicationCode("EMS11-C3FD3")
        }))
        
        let expectedResponse = ["success": false]
        var result = [String: Any]()
        
        command?.execute(arguments: [:]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: Bool], expectedResponse)
    }
}
