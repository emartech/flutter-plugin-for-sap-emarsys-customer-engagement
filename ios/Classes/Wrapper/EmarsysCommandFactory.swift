//
// Created by Emarsys on 2021. 04. 22..
//

class EmarsysCommandFactory {
    private var pushEventCallback: EventCallback
    private var silentPushEventCallback: EventCallback
    
    init(pushEventCallback: @escaping EventCallback, silentPushEventCallback: @escaping EventCallback) {
        self.pushEventCallback = pushEventCallback
        self.silentPushEventCallback = silentPushEventCallback
    }

    func create(name: String) -> EmarsysCommandProtocol? {
        var result: EmarsysCommandProtocol?
        switch name {
        case "setup":
            result = SetupCommand(pushEventCallback: pushEventCallback, silentPushEventCallback: silentPushEventCallback)
        case "setContact":
            result = SetContactCommand()
        case "clearContact":
            result = ClearContactCommand()
        case "push.enablePushSending":
            result = PushSendingEnabledCommand()
        case "push.android.registerNotificationChannels":
            result = EmptyCommand()
        case "config.applicationCode":
            result = ApplicationCodeCommand()
        case "config.merchantId":
            result = MerchantIdCommand()
        case "config.contactFieldId":
            result = ContactFieldIdCommand()
        case "config.hardwareId":
            result = HardwareIdCommand()
        case "config.languageCode":
            result = LanguageCodeCommand()
        case "config.notificationSettings":
            result = NotificationSettingsCommand()
        case "config.sdkVersion":
            result = SdkVersionCommand()
        default:
            result = nil
        }
        return result
    }

}
