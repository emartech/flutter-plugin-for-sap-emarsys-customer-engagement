//
//  Created by Emarsys on 2024. 04. 11.
//

import Foundation
@testable import EmarsysSDK

class TestProduct: NSObject, EMSProductProtocol {
    let productId: String
    let title: String
    let linkUrl: URL
    let customFields: [String: Any]
    let feature: String
    let cohort: String
    let imageUrl: URL?
    let zoomImageUrl: URL?
    let categoryPath: String?
    let available: NSNumber?
    let productDescription: String?
    let price: NSNumber?
    let msrp: NSNumber?
    let album: String?
    let actor: String?
    let artist: String?
    let author: String?
    let brand: String?
    let year: NSNumber?
    
    init(productId: String, title: String, linkUrl: URL, customFields: [String : String], feature: String, cohort: String, imageUrl: URL?, zoomImageUrl: URL?, categoryPath: String?, available: NSNumber?, productDescription: String?, price: NSNumber?, msrp: NSNumber?, album: String?, actor: String?, artist: String?, author: String?, brand: String?, year: NSNumber?) {
        self.productId = productId
        self.title = title
        self.linkUrl = linkUrl
        self.customFields = customFields
        self.feature = feature
        self.cohort = cohort
        self.imageUrl = imageUrl
        self.zoomImageUrl = zoomImageUrl
        self.categoryPath = categoryPath
        self.available = available
        self.productDescription = productDescription
        self.price = price
        self.msrp = msrp
        self.album = album
        self.actor = actor
        self.artist = artist
        self.author = author
        self.brand = brand
        self.year = year
    }
}
