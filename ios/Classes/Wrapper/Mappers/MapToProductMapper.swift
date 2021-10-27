//
//  Created by Emarsys on 2021. 10. 21..
//

import EmarsysSDK

class MapToProductMapper: Mappable {

    typealias Input = [String: Any]?
    typealias Output = Product?

    func map(_ input: [String: Any]?) -> Product? {
        guard input != nil else {
            return nil
        }
        return Product(
                productId: input!["productId"] as! String,
                title: input!["title"] as! String,
                linkUrlString: input!["linkUrlString"] as! String,
                feature: input!["feature"] as! String,
                cohort: input!["cohort"] as! String,
                customFields: input!["customFields"] as! [String: Any],
                imageUrlString: input!["imageUrlString"] as! String?,
                zoomImageUrlString: input!["zoomImageUrlString"] as! String?,
                categoryPath: input!["categoryPath"] as! String?,
                available: input!["available"] as! Bool?,
                productDescription: input!["productDescription"] as! String?,
                price: input!["price"] as! Double?,
                msrp: input!["msrp"] as! Double?,
                album: input!["album"] as! String?,
                actor: input!["actor"] as! String?,
                artist: input!["artist"] as! String?,
                author: input!["author"] as! String?,
                brand: input!["brand"] as! String?,
                year: input!["year"] as! Int?
        )
    }
}
