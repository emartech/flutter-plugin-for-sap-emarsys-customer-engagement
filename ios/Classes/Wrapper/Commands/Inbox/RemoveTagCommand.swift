//
//  Created by Emarsys on 2021. 08. 19..
//

import EmarsysSDK

class RemoveTagCommand: EmarsysCommandProtocol {
        
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let tag = arguments?["tag"] as? String else {
            resultCallback(["error": "Invalid tag"])
            return
        }
        guard let messageId = arguments?["messageId"] as? String else {
            resultCallback(["error": "Invalid messageId"])
            return
        }
        Emarsys.messageInbox.removeTag(tag: tag,
                                       messageId: messageId) { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                resultCallback(["success": true])
            }
        }
    }
}
