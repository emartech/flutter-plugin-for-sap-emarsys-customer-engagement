//
// Created by Emarsys on 2021. 10. 26..
//

@testable import emarsys_sdk
import EmarsysSDK
import XCTest

class MapToProductMapperTests: XCTestCase {

    var mapper: MapToProductMapper!

    override func setUp() {
        super.setUp()
        mapper = MapToProductMapper()
    }

    func testMap() throws {
        let expected = Product(productId: "productId",
                title: "title",
                linkUrl: "https://emarsys.com",
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
                year: 2012)
        let input: [String: Any] = [
            "productId": "productId",
            "title": "title",
            "linkUrl": "https://emarsys.com",
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
            "year": 2012,
        ]
        let result = mapper.map(input)

        XCTAssertEqual(result, expected)
    }
}
