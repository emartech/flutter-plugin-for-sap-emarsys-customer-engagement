//
// Created by Emarsys on 2021. 10. 26..
//

import EmarsysSDK

class TrackRecommendationClickCommand: EmarsysCommandProtocol {
    private let mapToProductMapper: MapToProductMapper

    init(mapToProductMapper: MapToProductMapper) {
        self.mapToProductMapper = mapToProductMapper
    }

    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback) {
        guard let productMap = arguments?["product"] as? [String: Any] else {
            resultCallback(["error": "Invalid product argument"])
            return
        }
        let product: Product = mapToProductMapper.map(productMap)!

        Emarsys.predict.trackRecommendationClick(product: product)

        resultCallback(["success": true])
    }
}
