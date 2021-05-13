//
// Created by Emarsys on 2021. 04. 22..
//

class EmarsysCommandFactory {

    func create(name: String) -> EmarsysCommandProtocol? {
        var result: EmarsysCommandProtocol?
        switch name {
        case "setup":
            result = SetupCommand()
        case "setContact":
            result = SetContactCommand()
        case "clearContact":
            result = ClearContactCommand()
        case "push.enablePushSending":
            result = EnablePushSendingCommand()
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
        case "config.pushSettings":
            result = PushSettingsCommand()
        case "config.sdkVersion":
            result = SdkVersionCommand()
        default:
            result = nil
        }
        return result
    }

}
