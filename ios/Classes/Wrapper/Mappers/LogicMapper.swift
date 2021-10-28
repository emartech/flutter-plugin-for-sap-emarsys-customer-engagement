//
//  Created by Emarsys on 2021. 10. 25.
//

import Foundation
import EmarsysSDK

class LogicMapper: Mappable {
    typealias Input = [String: Any]
    typealias Output = EMSLogic?
    
    func map(_ input: [String : Any]) -> EMSLogic? {
    let data = input["data"] as! Dictionary<String, Any>
    let variants = input["variants"] as! Array<String>
        
            var logic: EMSLogic? = nil
       switch input["name"] as? String {
       case "SEARCH":
           if let searchTerm = data["searchTerm"] as? String {
               logic = EMSLogic.search(searchTerm: searchTerm)
           } else {
               logic = EMSLogic.search()
           }
       case "CART":
           if let cartItemsMap = data["items"] as? [[String: Any]] {
               let cartItems = cartItemsMap.map{
                   EMSCartItem(itemId: ($0["itemId"] as! String), price: $0["price"] as! Double, quantity: $0["quantity"] as! Double) as EMSCartItemProtocol
               }
               logic = EMSLogic.cart(cartItems: cartItems)
           } else {
               logic = EMSLogic.cart()
           }
       case "CATEGORY":
           if let categoryPath = data["categoryPath"] as? String {
               logic = EMSLogic.category(categoryPath: categoryPath)
           } else {
               logic = EMSLogic.category()
           }
       case "POPULAR":
           if let categoryPath = data["categoryPath"] as? String {
               logic = EMSLogic.popular(categoryPath: categoryPath)
           } else {
               logic = EMSLogic.popular()
           }
       case "RELATED":
           if let itemId = data["itemId"] as? String {
               logic = EMSLogic.related(itemId: itemId)
           } else {
               logic = EMSLogic.related()
           }
       case "ALSO_BOUGHT":
           if let itemId = data["itemId"] as? String {
               logic = EMSLogic.alsoBought(itemId: itemId)
           } else {
               logic = EMSLogic.alsoBought()
           }
       case "HOME":
           if (variants.isEmpty) {
               logic = EMSLogic.home()
           } else {
               logic = EMSLogic.home(variants: variants)
           }
       case "PERSONAL":
           if (variants.isEmpty) {
               logic = EMSLogic.personal()
           } else {
               logic = EMSLogic.personal(variants: variants)
           }
       default:
           logic = nil
            
        }
        return logic
    }
}
