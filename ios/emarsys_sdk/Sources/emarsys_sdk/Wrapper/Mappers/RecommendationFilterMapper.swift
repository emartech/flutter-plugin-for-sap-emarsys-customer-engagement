//
//  Created by Emarsys on 2021. 10. 25.
//

import Foundation
import EmarsysSDK

class RecommendationFilterMapper: Mappable {
    typealias Input = [[String: Any]]
    typealias Output = [EMSRecommendationFilter]?
    
    func map(_ input: [[String : Any]]) -> [EMSRecommendationFilter]? {
        let filters = input.map{
            mapToTrigger($0)
        }.compactMap{
            $0
        }
        return filters.isEmpty ? nil : filters
    }
    
    private func mapToTrigger(_ filterMap: [String : Any]) -> EMSRecommendationFilter? {
        guard let values = filterMap["values"] as? [String] else {
            return nil
        }
        var filter : EMSRecommendationFilterProtocol? = nil
        switch filterMap["filterType"] as! String {
        case "INCLUDE":
            switch filterMap["comparison"] as! String {
            case "IS":
                filter = EMSRecommendationFilter.include(withField: filterMap["field"] as! String, isValue: values[0])
            case "HAS":
                filter = EMSRecommendationFilter.include(withField: filterMap["field"] as! String, hasValue: values[0])
            case "IN":
                filter = EMSRecommendationFilter.include(withField: filterMap["field"] as! String, inValues: values)
            case "OVERLAPS":
                filter = EMSRecommendationFilter.include(withField: filterMap["field"] as! String, overlapsValues: values)
            default:
                filter = nil
            }
            
        case "EXCLUDE":
            switch filterMap["comparison"] as! String {
            case "IS":
                filter = EMSRecommendationFilter.excludeFilter(withField: filterMap["field"] as! String, isValue: values[0])
            case "HAS":
                filter = EMSRecommendationFilter.excludeFilter(withField: filterMap["field"] as! String, hasValue: values[0])
            case "IN":
                filter = EMSRecommendationFilter.excludeFilter(withField: filterMap["field"] as! String, inValues: values)
            case "OVERLAPS":
                filter = EMSRecommendationFilter.excludeFilter(withField: filterMap["field"] as! String, overlapsValues: values)
            default:
                filter = nil
            }
            
        default:
            filter = nil
        }
        return filter as! EMSRecommendationFilter?
    }
}
