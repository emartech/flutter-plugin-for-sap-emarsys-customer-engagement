//
//  Created by Emarsys on 2024. 04. 11.
//

import Foundation
import EmarsysSDK

extension EMSLogic: CustomStringConvertible {
    open override var description: String {
        return "(logic: \(String(describing: self.logic)), data: \(String(describing: self.data)), variants: \(String(describing: self.variants))"
    }
}
