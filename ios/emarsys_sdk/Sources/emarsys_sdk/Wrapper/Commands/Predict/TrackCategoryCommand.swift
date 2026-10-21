//
//  Created by Emarsys
//

import EmarsysSDK

class TrackCategoryCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let categoryPath = arguments?["categoryPath"] as? String else {
            resultCallback(["error": "Invalid categoryPath argument"])
            return
        }
        
        Emarsys.predict.trackCategory(categoryPath: categoryPath)

        resultCallback(["success": true])
    }
}
