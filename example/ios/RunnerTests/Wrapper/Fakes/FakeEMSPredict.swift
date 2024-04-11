//
//  Created by Emarsys on 2024. 04. 10.
//

import EmarsysSDK

final class FakeEMSPredict: NSObject, EMSPredictProtocol {
    
    
    func trackCart(items: [any EMSCartItemProtocol]) {}
    
    func trackPurchase(orderId: String, items: [any EMSCartItemProtocol]) {}
    
    func trackCategory(categoryPath: String) {}
    
    func trackItem(itemId: String) {}
    
    func trackSearch(searchTerm: String) {}
    
    func trackTag(tag: String, attributes: [String : String]? = nil) {}
    
    func recommendProducts(logic: any EMSLogicProtocol, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: nil, limit: nil, availabilityZone: nil, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, limit: NSNumber?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: nil, limit: limit, availabilityZone: nil, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, filters: [any EMSRecommendationFilterProtocol]?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: filters, limit: nil, availabilityZone: nil, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, filters: [any EMSRecommendationFilterProtocol]?, limit: NSNumber?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: filters, limit: limit, availabilityZone: nil, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: nil, limit: nil, availabilityZone: availabilityZone, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, limit: NSNumber?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: nil, limit: limit, availabilityZone: availabilityZone, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, filters: [any EMSRecommendationFilterProtocol]?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        recommendProducts(logic: logic, filters: filters, limit: nil, availabilityZone: availabilityZone, productsBlock: productsBlock)
    }
    
    func recommendProducts(logic: any EMSLogicProtocol, filters: [any EMSRecommendationFilterProtocol]?, limit: NSNumber?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        
    }
    
    func trackRecommendationClick(product: any EMSProductProtocol) {
        
    }
}
