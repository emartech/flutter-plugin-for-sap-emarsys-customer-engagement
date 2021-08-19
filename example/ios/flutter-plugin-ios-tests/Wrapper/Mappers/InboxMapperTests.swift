//
//  Created by Emarsys on 2021. 08. 19..
//

import XCTest
@testable import emarsys_sdk
import EmarsysSDK

class InboxMapperTests: XCTestCase {
    
    var mapper: InboxMapper!
    
    override func setUp() {
        super.setUp()
        mapper = InboxMapper()
    }
    
    func testMap() throws {
        let message1 = EMSMessage(id: "ef14afa4",
                                  campaignId: "campaignId",
                                  collapseId: "collapseId",
                                  title: "title",
                                  body: "body",
                                  imageUrl: "https://example.com/image.jpg",
                                  receivedAt: 142141412515,
                                  updatedAt: 142141412599,
                                  expiresAt: 142141412599,
                                  tags: ["tag1", "tag2"],
                                  properties: [
                                    "key1": "value1",
                                    "key2": "value2"
                                  ],
                                  actions: [
                                    EMSAppEventActionModel(id: "testId1",
                                                           title: "testTitle1",
                                                           type: "MEAppEvent",
                                                           name: "testName1",
                                                           payload: [
                                                            "key1": "value1",
                                                            "key2": "value2"
                                                           ]),
                                    EMSOpenExternalUrlActionModel(id: "testId2",
                                                                  title: "testTitle2",
                                                                  type: "OpenExternalUrl",
                                                                  url: URL(string: "https://www.emarsys.com")!)])
        
        let message2 = EMSMessage(id: "testId2",
                                  campaignId: "campaignId2",
                                  collapseId: "collapseId2",
                                  title: "title2",
                                  body: "body2",
                                  imageUrl: "https://example.com/image2.jpg",
                                  receivedAt: 2222,
                                  updatedAt: 2222,
                                  expiresAt: 250,
                                  tags: ["tag21", "tag22"],
                                  properties: [
                                    "key3": "value3",
                                    "key4": "value4"
                                  ],
                                  actions: [
                                    EMSCustomEventActionModel(id: "testId3",
                                                              title: "testTitle3",
                                                              type: "MECustomEvent",
                                                              name: "testName3",
                                                              payload: [
                                                                "key3": "value3",
                                                                "key4": "value4"])])
        
        let message3 = EMSMessage(id: "testId3",
                                  campaignId: "campaignId3",
                                  collapseId: nil,
                                  title: "title3",
                                  body: "body3",
                                  imageUrl: nil,
                                  receivedAt: 2222,
                                  updatedAt: nil,
                                  expiresAt: nil,
                                  tags: nil,
                                  properties: nil,
                                  actions: nil)
        
        
        let expectedResult = [
            [
                "id": "ef14afa4",
                "campaignId": "campaignId",
                "collapseId": "collapseId",
                "title": "title",
                "body": "body",
                "imageUrl": "https://example.com/image.jpg",
                "receivedAt": 142141412515,
                "updatedAt": 142141412599,
                "expiresAt": 142141412599,
                "tags": ["tag1", "tag2"],
                "properties": [
                    "key1": "value1",
                    "key2": "value2"
                ],
                "actions": [
                    ["id": "testId1",
                     "title": "testTitle1",
                     "type": "MEAppEvent",
                     "name": "testName1",
                     "payload": [
                        "key1": "value1",
                        "key2": "value2"
                     ]],
                    ["id": "testId2",
                     "title": "testTitle2",
                     "type": "OpenExternalUrl",
                     "url": "https://www.emarsys.com"]
                ]
            ],
            [
                "id": "testId2",
                "campaignId": "campaignId2",
                "collapseId": "collapseId2",
                "title": "title2",
                "body": "body2",
                "imageUrl": "https://example.com/image2.jpg",
                "receivedAt": 2222,
                "updatedAt": 2222,
                "expiresAt": 250,
                "tags": ["tag21", "tag22"],
                "properties": [
                    "key3": "value3",
                    "key4": "value4"
                ],
                "actions": [
                    ["id": "testId3",
                     "title": "testTitle3",
                     "type": "MECustomEvent",
                     "name": "testName3",
                     "payload": [
                        "key3": "value3",
                        "key4": "value4"
                     ]
                    ]
                ]
            ],
            [
                "id": "testId3",
                "campaignId": "campaignId3",
                "title": "title3",
                "body": "body3",
                "receivedAt": 2222
            ]
        ]
        
        let result = self.mapper.map([message1, message2, message3])
        
        XCTAssertEqual(NSArray(array: result!), NSArray(array: expectedResult))
    }
    
}
