//
//  Created by Emarsys on 2021. 10. 25.
//

import Foundation
import EmarsysSDK

class ProductMapper: Mappable {
    typealias Input = [EMSProduct]
    typealias Output = [[String: Any]]?
    
    func map(_ input: [EMSProduct]) -> [[String : Any]]? {
        return []
    }
    
    
    
//    func map(_ input: [EMSMessage]) -> [[String : Any]]? {
//        let messageDicts: [[String: Any]]? = input.map { message in
//            var messageDict = [String: Any]()
//            messageDict["id"] = message.id
//            messageDict["campaignId"] = message.campaignId
//            messageDict["collapseId"] = message.collapseId
//            messageDict["title"] = message.title
//            messageDict["body"] = message.body
//            messageDict["imageUrl"] = message.imageUrl
//            messageDict["receivedAt"] = message.receivedAt
//            messageDict["updatedAt"] = message.updatedAt
//            messageDict["expiresAt"] = message.expiresAt
//            messageDict["tags"] = message.tags
//            messageDict["properties"] = message.properties
//            if let actions = message.actions {
//                let actionDicts: [[String: Any]]? = actions.map { action in
//                    return dictFromAction(action: action)
//                }
//                messageDict["actions"] = actionDicts
//            }
//            return messageDict
//        }
//        return messageDicts
//    }
}
