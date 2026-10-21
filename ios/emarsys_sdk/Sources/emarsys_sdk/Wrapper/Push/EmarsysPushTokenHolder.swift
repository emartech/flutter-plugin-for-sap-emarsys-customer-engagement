//
//  Created by Emarsys on 2021.
//

import EmarsysSDK

public class EmarsysPushTokenHolder {

    public static var enabled = true
    
    public static var pushTokenObserver: ((Data?) -> ())?
    
    public static var pushToken: Data? {
        didSet {
            if pushTokenObserver != nil {
                pushTokenObserver!(pushToken)
            }
        }
    }
}
