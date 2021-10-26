//
//  Created by Emarsys on 2021. 10. 25..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class RecommendationFilterMapperTests: XCTestCase {
    
    var mapper: RecommendationFilterMapper!
    
    override func setUp() {
        super.setUp()
        mapper = RecommendationFilterMapper()
    }
    
    func testMap_withEmptyInput() throws {
        let expectation : [EMSRecommendationFilter]? = nil
        let filter : [[String : Any]] = []
        
        let result = self.mapper.map(filter)
        
        XCTAssertEqual(result, expectation)
    }
    
    func testMap_excludeFilters() throws {
        let expectation = [EMSRecommendationFilter.excludeFilter(withField: "testField1", isValue: "testValue1"),
                           EMSRecommendationFilter.excludeFilter(withField: "testField2", hasValue: "testValue2"),
                           EMSRecommendationFilter.excludeFilter(withField: "testField3", inValues: ["testValue3", "testValue4"]),
                           EMSRecommendationFilter.excludeFilter(withField: "testField4", overlapsValues: ["testValue5", "testValue6"])
        ] as! [EMSRecommendationFilter]
        let filters = [["filterType": "EXCLUDE",
                       "field": "testField1",
                       "comparison": "IS",
                       "values": ["testValue1"] as [String]],
                      ["filterType": "EXCLUDE",
                       "field": "testField2",
                       "comparison": "HAS",
                       "values": ["testValue2"] as [String]],
                      ["filterType": "EXCLUDE",
                       "field": "testField3",
                       "comparison": "IN",
                       "values": ["testValue3", "testValue4"] as [String]],
                      ["filterType": "EXCLUDE",
                       "field": "testField4",
                       "comparison": "OVERLAPS",
                       "values": ["testValue5", "testValue6"] as [String]],
        ]
        
        
        let result = self.mapper.map(filters)!
        
        XCTAssertEqual(result, expectation)
    }
    
    
    func testMap_includeFilters() throws {
        let expectation = [EMSRecommendationFilter.include(withField: "testField1", isValue: "testValue1"),
                           EMSRecommendationFilter.include(withField: "testField2", hasValue: "testValue2"),
                           EMSRecommendationFilter.include(withField: "testField3", inValues: ["testValue3", "testValue4"]),
                           EMSRecommendationFilter.include(withField: "testField4", overlapsValues: ["testValue5", "testValue6"])
        ] as! [EMSRecommendationFilter]
        let filters = [["filterType": "INCLUDE",
                       "field": "testField1",
                       "comparison": "IS",
                       "values": ["testValue1"] as [String]],
                      ["filterType": "INCLUDE",
                       "field": "testField2",
                       "comparison": "HAS",
                       "values": ["testValue2"] as [String]],
                      ["filterType": "INCLUDE",
                       "field": "testField3",
                       "comparison": "IN",
                       "values": ["testValue3", "testValue4"] as [String]],
                      ["filterType": "INCLUDE",
                       "field": "testField4",
                       "comparison": "OVERLAPS",
                       "values": ["testValue5", "testValue6"] as [String]],
        ]
        
        
        let result = self.mapper.map(filters)!
        
        XCTAssertEqual(result, expectation)
    }

}
