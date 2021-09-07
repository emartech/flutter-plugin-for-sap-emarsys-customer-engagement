//
// Created by Emarsys on 2021. 04. 22..
//
import EmarsysSDK

class EmarsysCommandFactory {
    
    var pushEventHandler: EMSEventHandlerBlock
    var silentPushEventHandler: EMSEventHandlerBlock
    var geofenceEventHandler: EMSEventHandlerBlock
    var inboxMapper: InboxMapper
    var inAppEventHandler: EMSEventHandlerBlock
    
    init(pushEventHandler: @escaping EMSEventHandlerBlock,
         silentPushEventHandler: @escaping EMSEventHandlerBlock,
         inboxMapper: InboxMapper,
         geofenceEventHandler: @escaping EMSEventHandlerBlock,
         inAppEventHandler: @escaping EMSEventHandlerBlock) {
        self.pushEventHandler = pushEventHandler
        self.silentPushEventHandler = silentPushEventHandler
        self.inboxMapper = inboxMapper
        self.geofenceEventHandler = geofenceEventHandler
        self.inAppEventHandler = inAppEventHandler
    }

    func create(name: String) -> EmarsysCommandProtocol? {
        var result: EmarsysCommandProtocol?
        switch name {
        case "setup":
            result = SetupCommand(pushEventHandler: self.pushEventHandler,
                                  silentPushEventHandler: self.silentPushEventHandler,
                                  geofenceEventHandler: self.geofenceEventHandler,
                                  inAppEventHandler: self.inAppEventHandler)
        case "setContact":
            result = SetContactCommand()
        case "clearContact":
            result = ClearContactCommand()
        case "push.pushSendingEnabled":
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
        case "config.changeApplicationCode":
            result = ChangeApplicationCodeCommand()
        case "trackCustomEvent":
            result = TrackCustomEventCommand()
        case "inbox.fetchMessages":
            result = FetchMessagesCommand(inboxMapper: inboxMapper)
        case "inbox.addTag":
            result = AddTagCommand()
        case "inbox.removeTag":
            result = RemoveTagCommand()
        case "geofence.enable":
            result = GeofenceEnableCommand()
        case "geofence.disable":
            result = GeofenceDisableCommand()
        case "geofence.setInitialEnterTriggerEnabled":
            result = GeofenceSetInitialEnterTriggerEnabledCommand()
        case "geofence.ios.requestAlwaysAuthorization":
            result = GeofenceiOSRequestAlwaysAuthorizationCommand()
        case "geofence.isEnabled":
            result = GeofenceisEnabledCommand()
        case "inApp.pause":
            result = InAppPauseCommand()
        case "inApp.resume":
            result = InAppResumeCommand()
        case "inApp.isPaused":
            result = InAppIsPausedCommand()
        default:
            result = nil
        }
        return result
    }

}
