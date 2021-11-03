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
            $0.toMap()
        }
    }
}

extension EMSProductProtocol {
    func toMap() -> [String: Any] {
        var result = [String: Any]();
        
        result["productId"] = productId
        result["title"] = title
        result["linkUrlString"] = linkUrl.absoluteString
        result["feature"] = feature
        result["cohort"] = cohort
        result["customFields"] = customFields
        if let imageUrlString = imageUrl {
            result["imageUrlString"] = imageUrlString.absoluteString
        }
        if let zoomImageUrlString = zoomImageUrl {
            result["zoomImageUrlString"] = zoomImageUrlString.absoluteString
        }
        if let categoryPath = categoryPath {
            result["categoryPath"] = categoryPath
        }
        if let available = available {
            result["available"] = available
        }
        if let productDescription = productDescription {
            result["productDescription"] = productDescription
        }
        if let price = price {
            result["price"] = price
        }
        if let msrp = msrp {
            result["msrp"] = msrp
        }
        if let album = album {
            result["album"] = album
        }
        if let actor = actor {
            result["actor"] = actor
        }
        if let artist = artist {
            result["artist"] = artist
        }
        if let author = author {
            result["author"] = author
        }
        if let brand = brand {
            result["brand"] = brand
        }
        if let year = year {
            result["year"] = year
        }
        
        return result
    }
}
