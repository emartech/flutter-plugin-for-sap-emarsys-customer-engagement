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
