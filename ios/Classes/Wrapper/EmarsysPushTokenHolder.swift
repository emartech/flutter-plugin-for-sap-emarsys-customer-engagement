import EmarsysSDK

public class EmarsysPushTokenHolder {

    public static var enabled = true
    
    public static var pushToken: Data? {
        didSet {
            if enabled, let token = pushToken {
                Emarsys.push.setPushToken(token)
            }
        }
    }

}
