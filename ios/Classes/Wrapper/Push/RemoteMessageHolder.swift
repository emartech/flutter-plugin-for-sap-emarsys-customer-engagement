//
//  Created by Emarsys on 2026.
//

import EmarsysSDK

public class RemoteMessageHolder {

    public static let instance = RemoteMessageHolder()

    private var cache = [[AnyHashable: Any]]()
    private(set) var setupCompleted = false

    public func handleMessage(userInfo: [AnyHashable: Any]) {
        if setupCompleted {
            Emarsys.push.handleMessage(userInfo: userInfo)
        } else {
            cache.append(userInfo)
        }
    }

    public func emptyCache() {
        setupCompleted = true
        let cached = cache
        cache.removeAll()
        cached.forEach { userInfo in
            Emarsys.push.handleMessage(userInfo: userInfo)
        }
    }
}
