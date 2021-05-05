import EmarsysSDK

public class EmarsysPushTokenHolder {

    public static var enabled = false
    
    public static var pushToken: Data? {
        didSet {
            if enabled, let token = pushToken {
                Emarsys.push.setPushToken(token)
            }
        }
    }

}
