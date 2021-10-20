//
//  Created by Emarsys
//

import EmarsysSDK

class TrackCartItemCommand: EmarsysCommandProtocol {
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let items = arguments?["items"] as? [[String:Any]] else {
            resultCallback(["error": "Invalid items argument"])
            return
        }
        let cartItems:[EMSCartItem] = items.map { cartItem in
            EMSCartItem(
                itemId: cartItem["itemId"] as? String,
                price: cartItem["price"] as! Double,
                quantity: cartItem["quantity"] as! Double
            )
        }
  
        Emarsys.predict.trackCart(items: cartItems)

        resultCallback(["success": true])
    }
}
