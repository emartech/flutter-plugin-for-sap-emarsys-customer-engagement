//
// Created by Emarsys
//

import EmarsysSDK

class RecommendProductsCommand: EmarsysCommandProtocol {
    var productMapper: ProductMapper
    var logicMapper: LogicMapper
    var recommendationFilterMapper: RecommendationFilterMapper
    
    init(productMapper: ProductMapper,
         logicMapper: LogicMapper,
         recommendationFilterMapper: RecommendationFilterMapper) {
        self.productMapper = productMapper
        self.logicMapper = logicMapper
        self.recommendationFilterMapper = recommendationFilterMapper
    }
    
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let logicDict = arguments?["logic"] as? Dictionary<String, Any> else {
            resultCallback(["error": "Invalid logic argument"])
            return
        }
        guard (logicDict["data"] as? Dictionary<String, Any>) != nil else {
            resultCallback(["error": "Invalid logic data"])
            return
        }
        guard (logicDict["variants"] as? Array<String>) != nil else {
            resultCallback(["error": "Invalid logic variants"])
            return
        }
        
        let logic = logicMapper.map(logicDict)
        
        guard let logic = logic else {
            resultCallback(["error": "Invalid logic name"])
            return
        }
        var filters: [EMSRecommendationFilterProtocol]? = nil
        if let filtersMap = arguments?["filters"] {
            filters = recommendationFilterMapper.map(filtersMap as! [[String : Any]])
        }
        let limit: Int? = arguments?["limit"] != nil ? arguments?["limit"] as? Int : nil
        let availabilityZone: String? = arguments?["availabilityZone"] != nil ? arguments?["availabilityZone"] as? String : nil
        
        Emarsys.predict.recommendProducts(logic: logic, filters: filters, limit: limit as NSNumber?, availabilityZone: availabilityZone, productsBlock: { result, error in
            if let res = result {
                let products: [EMSProduct] = res
                if let productsDict = self.productMapper.map(products) {
                    resultCallback(["success": productsDict])
                } else {
                    resultCallback(["success": []])
                }
            } else if let e = error {
                resultCallback(["error": e])
            }
        })
        
    }
}
