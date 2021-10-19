//
//  Created by Emarsys on 2021. 10. 18..
//

import EmarsysSDK

class ChangeMerchantIdCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let merchantId = arguments?["merchantId"] as? String else {
            resultCallback(["error": "Invalid merchantId"])
            return
        }
        Emarsys.config.changeMerchantId(merchantId: merchantId)
        resultCallback(["success": true])
    }
}

