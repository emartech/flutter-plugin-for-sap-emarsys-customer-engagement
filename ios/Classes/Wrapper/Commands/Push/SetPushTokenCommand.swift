//
// Created by Emarsys
//

import Foundation
import EmarsysSDK

public class SetPushTokenCommand: EmarsysCommandProtocol {
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        guard let pushToken = arguments?["pushToken"] as? String else {
            resultCallback(["error": "Invalid pushToken argument"])
            return
        }
        
        let pushData = convertPushToken(token: pushToken)
        
        Emarsys.push.setPushToken(pushToken: pushData) { error in
            if let e = error {
                resultCallback(["error": e])
            } else {
                resultCallback(["success": true])
            }
        }
    }
    
    func convertPushToken(token: String) -> Data {
        let len = token.count / 2
        var data = Data(capacity:len)
        let ptr = token.cString(using: String.Encoding.utf8)!
        
        for i in 0..<len {
            var num: UInt8 = 0
            var multi: UInt8 = 16;
            for j in 0..<2 {
                let c: UInt8 = UInt8(ptr[i*2+j])
                var offset: UInt8 = 0
                
                switch c {
                case 48...57:
                    offset = 48
                case 65...70:
                    offset = 65 - 10
                case 97...102:
                    offset = 97 - 10
                default:
                    assert(false)
                }
                
                num += (c - offset)*multi
                multi = 1
            }
            data.append(num)
        }
        return data;
    }
    
}
