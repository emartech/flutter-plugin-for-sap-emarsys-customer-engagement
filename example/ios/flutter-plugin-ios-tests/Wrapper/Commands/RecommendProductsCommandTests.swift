//
//  Created by Emarsys on 2021. 10. 18..
//

import XCTest
@testable import emarsys_sdk


class RecommendProductsCommandTests: XCTestCase {
    var command: EmarsysCommandProtocol!
    var productsMapper: ProductsMapper!
    var logicMapper: LogicMapper!
    var recommendationFilterMapper: RecommendationFilterMapper!
    
    override func setUpWithError() throws {
        productsMapper = ProductsMapper()
        logicMapper = LogicMapper()
        recommendationFilterMapper = RecommendationFilterMapper()
        
        command = RecommendProductsCommand(productsMapper: productsMapper,
                                           logicMapper: logicMapper,
                                           recommendationFilterMapper: recommendationFilterMapper)
    }
    
    func testExecute_returnError_whenLogicIsMissing() throws {
        let expectedResponse = ["error": "Invalid logic argument"]
        var result = [String: Any]()
        
        command.execute(arguments: nil) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
    func testExecute_returnError_whenLogicDataIsMissing() throws {
        let expectedResponse = ["error": "Invalid logic data"]
        var result = [String: Any]()
        
        command.execute(arguments: ["logic": ["logicName":" SEARCH",
                                              "variants": []]]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
    func testExecute_returnError_whenLogicVariantsIsMissing() throws {
        let expectedResponse = ["error": "Invalid logic variants"]
        var result = [String: Any]()
        
        command.execute(arguments: ["logic": ["logicName": "SEARCH",
                                              "data": [:]]]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
    
    func testExecute_returnError_whenLogicNameIsinvalid() throws {
        let expectedResponse = ["error": "Invalid logic name"]
        var result = [String: Any]()
        
        command.execute(arguments: ["logic": ["logicName": "testName",
                                              "data": [:],
                                              "variants": []]]) { response in
            result = response
        }
        
        XCTAssertEqual(result as? [String: String], expectedResponse)
    }
}
