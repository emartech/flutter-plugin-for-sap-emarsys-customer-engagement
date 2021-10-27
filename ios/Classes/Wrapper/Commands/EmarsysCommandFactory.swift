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
    var mapToProductMapper: MapToProductMapper
    var productsMapper: ProductsMapper
    var logicMapper: LogicMapper
    var recommendationFilterMapper: RecommendationFilterMapper

    init(pushEventHandler: @escaping EMSEventHandlerBlock,
         silentPushEventHandler: @escaping EMSEventHandlerBlock,
         inboxMapper: InboxMapper,
         geofenceEventHandler: @escaping EMSEventHandlerBlock,
         inAppEventHandler: @escaping EMSEventHandlerBlock,
         mapToProductMapper: MapToProductMapper,
         productsMapper: ProductsMapper,
         logicMapper: LogicMapper,
         recommendationFilterMapper: RecommendationFilterMapper) {
        self.pushEventHandler = pushEventHandler
        self.silentPushEventHandler = silentPushEventHandler
        self.inboxMapper = inboxMapper
        self.geofenceEventHandler = geofenceEventHandler
        self.inAppEventHandler = inAppEventHandler
        self.mapToProductMapper = mapToProductMapper
        self.productsMapper = productsMapper
        self.logicMapper = logicMapper
        self.recommendationFilterMapper = recommendationFilterMapper
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
        case "config.changeMerchantId":
            result = ChangeMerchantIdCommand()
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
        case "predict.trackCart":
            result = TrackCartItemCommand()
        case "predict.trackPurchase":
            result = TrackPurchaseCommand()
        case "predict.trackCategoryView":
            result = TrackCategoryCommand()
        case "predict.trackSearchTerm":
            result = TrackSearchTermCommand()
        case "predict.trackTag":
            result = TrackTagCommand()
        case "predict.trackItemView":
            result = TrackItemViewCommand()
        case "predict.recommendProducts":
            result = RecommendProductsCommand(productsMapper: productsMapper, logicMapper: logicMapper, recommendationFilterMapper: recommendationFilterMapper)
        case "predict.trackRecommendationClick":
            result = TrackRecommendationClickCommand(mapToProductMapper: mapToProductMapper)
        default:
            result = nil
        }
        return result
    }

}
