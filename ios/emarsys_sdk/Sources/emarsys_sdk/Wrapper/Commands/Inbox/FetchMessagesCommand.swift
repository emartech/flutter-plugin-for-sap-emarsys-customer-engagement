//
//  Created by Emarsys on 2021. 08. 18..
//

import EmarsysSDK

class FetchMessagesCommand: EmarsysCommandProtocol {
    
    var inboxMapper: InboxMapper
    
    init(inboxMapper: InboxMapper) {
        self.inboxMapper = inboxMapper
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        Emarsys.messageInbox.fetchMessages(resultBlock: { result, error in
            if let res = result {
                let messages: [EMSMessage] = res.messages
                if let messageDicts = self.inboxMapper.map(messages) {
                    resultCallback(["success": messageDicts])
                } else {
                    resultCallback(["success": []])
                }
            } else if let e = error {
                resultCallback(["error": e])
            }
        })
    }
}
