//
//  Created by Emarsys on 2021. 10. 25.
//

import Foundation
import EmarsysSDK

class ProductsMapper: Mappable {
    
    typealias Input = [EMSProductProtocol]
    typealias Output = [[String: Any?]]
    
    func map(_ input: [EMSProductProtocol]) -> [[String : Any?]] {
        input.map{
            ($0 as! Product).toMap()
        }
    }
}

extension Product {
    func toMap() -> [String : Any?] {
        ["productId": productId,
         "title": title,
         "linkUrlString": linkUrl.absoluteString,
         "feature": feature,
         "cohort": cohort,
         "customFields": customFields,
         "imageUrlString": imageUrl?.absoluteString,
         "zoomImageUrlString": zoomImageUrl?.absoluteString,
         "categoryPath": categoryPath,
         "available": available,
         "productDescription": productDescription,
         "price": price,
         "msrp": msrp,
         "album": album,
         "actor": actor,
         "artist": artist,
         "author": author,
         "brand": brand,
         "year": year]
    }
}
