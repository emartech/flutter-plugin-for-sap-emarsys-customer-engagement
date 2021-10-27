//
// Created by Emarsys
//

import EmarsysSDK

class RecommendProductsCommand: EmarsysCommandProtocol {
    var productsMapper: ProductsMapper
    var logicMapper: LogicMapper
    var recommendationFilterMapper: RecommendationFilterMapper
    
    init(productsMapper: ProductsMapper,
         logicMapper: LogicMapper,
         recommendationFilterMapper: RecommendationFilterMapper) {
        self.productsMapper = productsMapper
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
                let products: [EMSProductProtocol] = res
                let productsDict: [[String: Any?]] = self.productsMapper.map(products)
                
                resultCallback(["success": productsDict])
            } else if let e = error {
                resultCallback(["error": e])
            }
        })
        
    }
}
