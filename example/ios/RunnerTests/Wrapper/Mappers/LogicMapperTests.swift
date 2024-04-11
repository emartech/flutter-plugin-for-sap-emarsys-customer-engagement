//
//  Created by Emarsys on 2021. 10. 25..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class LogicMapperTests: XCTestCase {
    
    var mapper: LogicMapper!
    
    override func setUp() {
        super.setUp()
        mapper = LogicMapper()
    }
    
    func testMap_invalidName() throws {
        let logic = ["name": "invalid",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertNil(result)
    }
    
    func testMap_search() throws {
        let expectation = EMSLogic.search()
        let logic = ["name": "SEARCH",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_search_withTerm() throws {
        let expectation = EMSLogic.search(searchTerm: "testTerm")
        let logic = ["name": "SEARCH",
                     "data": ["searchTerm": "testTerm"],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_cart() throws {
        let expectation = EMSLogic.cart()
        let logic = ["name": "CART",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_cart_withItems() throws {
        let expectation = EMSLogic.cart(cartItems: [EMSCartItem(itemId: "testId", price: 12.2, quantity: 23.4),
                                                    EMSCartItem(itemId: "testId2", price: 12.22, quantity: 23.42)])
        let logic = ["name": "CART",
                     "data": ["cartItems": [
                        ["itemId" : "testId",
                         "price": 12.2,
                         "quantity" : 23.4],
                        ["itemId" : "testId2",
                         "price": 12.22,
                         "quantity" : 23.42]]],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_category() throws {
        let expectation = EMSLogic.category()
        let logic = ["name": "CATEGORY",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_category_withPath() throws {
        let expectation = EMSLogic.category(categoryPath: "testPath")
        let logic = ["name": "CATEGORY",
                     "data": ["categoryPath": "testPath"],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_popular() throws {
        let expectation = EMSLogic.popular()
        let logic = ["name": "POPULAR",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_popular_withPath() throws {
        let expectation = EMSLogic.popular(categoryPath: "testPath")
        let logic = ["name": "POPULAR",
                     "data": ["categoryPath": "testPath"],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_alsoBought() throws {
        let expectation = EMSLogic.alsoBought()
        let logic = ["name": "ALSO_BOUGHT",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_alsoBought_withPath() throws {
        let expectation = EMSLogic.alsoBought(itemId: "testItemId")
        let logic = ["name": "ALSO_BOUGHT",
                     "data": ["itemId": "testItemId"],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_related() throws {
        let expectation = EMSLogic.related()
        let logic = ["name": "RELATED",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_related_withPath() throws {
        let expectation = EMSLogic.related(itemId: "testItemId")
        let logic = ["name": "RELATED",
                     "data": ["itemId": "testItemId"],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_personal() throws {
        let expectation = EMSLogic.personal()
        let logic = ["name": "PERSONAL",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_personal_withPath() throws {
        let expectation = EMSLogic.personal(variants: ["testVariant1","testVariant2"])
        let logic = ["name": "PERSONAL",
                     "data": [:],
                     "variants": ["testVariant1","testVariant2"]] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_home() throws {
        let expectation = EMSLogic.home()
        let logic = ["name": "HOME",
                     "data": [:],
                     "variants": []] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_home_withPath() throws {
        let expectation = EMSLogic.home(variants: ["testVariant1","testVariant2"])
        let logic = ["name": "HOME",
                     "data": [:],
                     "variants": ["testVariant1","testVariant2"]] as [String : Any]
        
        
        let result = self.mapper.map(logic)
        
        XCTAssertEqual(result, expectation)
    }
    
}
