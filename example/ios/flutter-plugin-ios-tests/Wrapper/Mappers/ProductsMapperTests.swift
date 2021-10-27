//
//  Created by Emarsys on 2021. 10. 25..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class ProductsMapperTests: XCTestCase {
    
    var mapper: ProductsMapper!
    
    override func setUp() {
        super.setUp()
        mapper = ProductsMapper()
    }
    
    func testMap_withEmptyInput() throws {
        let expectation : [[String : Any?]] = []
        let products : [Product] = []
        
        let result : [[String : Any?]] = self.mapper.map(products)
        
        XCTAssertEqual(NSArray(array: result),
                       NSArray(array: expectation))
    }
    
    func testMap() throws {
        let expectation = [[
            "productId": "productId",
            "title": "title",
            "linkUrlString": "https://emarsys.com",
            "feature": "feature",
            "cohort": "cohort",
            "customFields": ["key": "value"],
            "imageUrlString": "https://emarsys.com",
            "zoomImageUrlString": "https://emarsys.com",
            "categoryPath": "categoryPath",
            "available": true,
            "productDescription": "productDescription",
            "price": 2.4,
            "msrp": 2.5,
            "album": "album",
            "actor": "actor",
            "artist": "artist",
            "author": "author",
            "brand": "brand",
            "year": 2012
        ],[
            "productId": "productId2",
            "title": "title2",
            "linkUrlString": "https://emarsys.com2",
            "feature": "feature2",
            "cohort": "cohort2",
            "customFields": ["key2": "value2"],
            "imageUrlString": "https://emarsys.com2",
            "zoomImageUrlString": "https://emarsys.com2",
            "categoryPath": "categoryPath2",
            "available": false,
            "productDescription": "productDescription2",
            "price": 2.42,
            "msrp": 2.52,
            "album": "album2",
            "actor": "actor2",
            "artist": "artist2",
            "author": "author2",
            "brand": "brand2",
            "year": 20122
        ]]
        let products : [Product] = [
            Product(
                productId: "productId",
                title: "title",
                linkUrlString: "https://emarsys.com",
                feature: "feature",
                cohort: "cohort",
                customFields: ["key": "value"],
                imageUrlString: "https://emarsys.com",
                zoomImageUrlString: "https://emarsys.com",
                categoryPath: "categoryPath",
                available: true,
                productDescription: "productDescription",
                price: 2.4,
                msrp: 2.5,
                album: "album",
                actor: "actor",
                artist: "artist",
                author: "author",
                brand: "brand",
                year: 2012),
            Product(
                productId: "productId2",
                title: "title2",
                linkUrlString: "https://emarsys.com2",
                feature: "feature2",
                cohort: "cohort2",
                customFields: ["key2": "value2"],
                imageUrlString: "https://emarsys.com2",
                zoomImageUrlString: "https://emarsys.com2",
                categoryPath: "categoryPath2",
                available: false,
                productDescription: "productDescription2",
                price: 2.42,
                msrp: 2.52,
                album: "album2",
                actor: "actor2",
                artist: "artist2",
                author: "author2",
                brand: "brand2",
                year: 20122)]
        
        let result = self.mapper.map(products)
        
        assertEquals(actual: result[0], expectation: expectation[0])
        assertEquals(actual: result[1], expectation: expectation[1])
    }
    
    func assertEquals(actual: [String:Any?], expectation: [String:Any?]) {
        XCTAssertEqual(actual["productId"] as! String, expectation["productId"] as! String)
        XCTAssertEqual(actual["title"] as! String, expectation["title"] as! String)
        XCTAssertEqual(actual["linkUrlString"] as! String, expectation["linkUrlString"] as! String)
        XCTAssertEqual(actual["feature"] as! String, expectation["feature"] as! String)
        XCTAssertEqual(actual["cohort"] as! String, expectation["cohort"] as! String)
        XCTAssertEqual(actual["customFields"] as! [String: String], expectation["customFields"] as! [String: String])
        XCTAssertEqual(actual["imageUrlString"] as! String, expectation["imageUrlString"] as! String)
        XCTAssertEqual(actual["zoomImageUrlString"] as! String, expectation["zoomImageUrlString"] as! String)
        XCTAssertEqual(actual["categoryPath"] as! String, expectation["categoryPath"] as! String)
        XCTAssertEqual(actual["available"] as! NSNumber, expectation["available"] as! NSNumber)
        XCTAssertEqual(actual["productDescription"] as! String, expectation["productDescription"] as! String)
        XCTAssertEqual(actual["price"] as! NSNumber, expectation["price"] as! NSNumber)
        XCTAssertEqual(actual["msrp"] as! NSNumber, expectation["msrp"] as! NSNumber)
        XCTAssertEqual(actual["album"] as! String, expectation["album"] as! String)
        XCTAssertEqual(actual["actor"] as! String, expectation["actor"] as! String)
        XCTAssertEqual(actual["artist"] as! String, expectation["artist"] as! String)
        XCTAssertEqual(actual["author"] as! String, expectation["author"] as! String)
        XCTAssertEqual(actual["brand"] as! String, expectation["brand"] as! String)
        XCTAssertEqual(actual["year"] as! NSNumber, expectation["year"] as! NSNumber)
    }
}
