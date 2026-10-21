//
//  Created by Emarsys on 2021. 08. 18..
//

import Foundation

protocol Mappable {
    
    associatedtype Input
    associatedtype Output
    
    mutating func map(_ input: Input) -> Output
    
}
