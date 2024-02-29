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
    
    func testExecute_returnCorrectValue_ForIsPaused() throws {
        Emarsys.setup(config: EMSConfig.make(builder: { builder in
            builder.setMobileEngageApplicationCode("EMS11-C3FD3")
        }))
        var result = [String: Any]()
        
        Emarsys.inApp.resume()
        
        command?.execute(arguments: [:]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: Bool], ["success": false])
        
        Emarsys.inApp.pause()
        
        command?.execute(arguments: [:]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: Bool], ["success": true])
    }
}
