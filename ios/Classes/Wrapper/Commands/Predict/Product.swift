//
//  Created by Emarsys on 2021. 10. 21..
//

import EmarsysSDK

class Product: NSObject, EMSProductProtocol {

    var productId: String

    var title: String

    var linkUrl: URL

    var customFields: [String: Any]

    var feature: String

    var cohort: String

    var imageUrl: URL?

    var zoomImageUrl: URL?

    var categoryPath: String?

    var available: NSNumber?

    var productDescription: String?

    var price: NSNumber?

    var msrp: NSNumber?

    var album: String?

    var actor: String?

    var artist: String?

    var author: String?

    var brand: String?

    var year: NSNumber?

    init(productId: String,
         title: String,
         linkUrlString: String,
         feature: String,
         cohort: String,
         customFields: [String: Any],
         imageUrlString: String?,
         zoomImageUrlString: String?,
         categoryPath: String?,
         available: Bool?,
         productDescription: String?,
         price: Double?,
         msrp: Double?,
         album: String?,
         actor: String?,
         artist: String?,
         author: String?,
         brand: String?,
         year: Int?) {
        self.productId = productId
        self.title = title
        self.linkUrl = URL.init(string: linkUrlString)!
        self.feature = feature
        self.cohort = cohort
        self.customFields = customFields
        self.imageUrl = imageUrlString != nil ? URL.init(string: imageUrlString!) : nil
        self.zoomImageUrl = zoomImageUrlString != nil ? URL.init(string: zoomImageUrlString!) : nil
        self.categoryPath = categoryPath
        self.available = available as NSNumber?
        self.productDescription = productDescription
        self.price = price as NSNumber?
        self.msrp = msrp as NSNumber?
        self.album = album
        self.actor = actor
        self.artist = artist
        self.author = author
        self.brand = brand
        self.year = year as NSNumber?

    }

    override var hash: Int {
        var result = productId.hashValue
        result = result &* 31 &+ title.hashValue
        result = result &* 31 &+ linkUrl.hashValue
        result = result &* 31 &+ feature.hashValue
        result = result &* 31 &+ cohort.hashValue
        result = result &* 31 &+ (imageUrl?.hashValue ?? 0)
        result = result &* 31 &+ (zoomImageUrl?.hashValue ?? 0)
        result = result &* 31 &+ (categoryPath?.hashValue ?? 0)
        result = result &* 31 &+ (available?.hashValue ?? 0)
        result = result &* 31 &+ (productDescription?.hashValue ?? 0)
        result = result &* 31 &+ (price?.hashValue ?? 0)
        result = result &* 31 &+ (msrp?.hashValue ?? 0)
        result = result &* 31 &+ (album?.hashValue ?? 0)
        result = result &* 31 &+ (actor?.hashValue ?? 0)
        result = result &* 31 &+ (artist?.hashValue ?? 0)
        result = result &* 31 &+ (author?.hashValue ?? 0)
        result = result &* 31 &+ (brand?.hashValue ?? 0)
        result = result &* 31 &+ (year?.hashValue ?? 0)
        return result
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Product else {
            return false
        }
        if self === object {
            return true
        }
        if type(of: self) != type(of: object) {
            return false
        }
        if self.productId != object.productId {
            return false
        }
        if self.title != object.title {
            return false
        }
        if self.linkUrl != object.linkUrl {
            return false
        }
        if self.feature != object.feature {
            return false
        }
        if self.cohort != object.cohort {
            return false
        }
        if self.imageUrl != object.imageUrl {
            return false
        }
        if self.zoomImageUrl != object.zoomImageUrl {
            return false
        }
        if self.categoryPath != object.categoryPath {
            return false
        }
        if self.available != object.available {
            return false
        }
        if self.productDescription != object.productDescription {
            return false
        }
        if self.price != object.price {
            return false
        }
        if self.msrp != object.msrp {
            return false
        }
        if self.album != object.album {
            return false
        }
        if self.actor != object.actor {
            return false
        }
        if self.artist != object.artist {
            return false
        }
        if self.author != object.author {
            return false
        }
        if self.brand != object.brand {
            return false
        }
        if self.year != object.year {
            return false
        }
        return true
    }
}

extension EMSProductProtocol {
    func toMap() -> [String: Any?] {
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
