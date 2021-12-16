package com.emarsys.emarsys_sdk.command

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.config.*
import com.emarsys.emarsys_sdk.command.geofence.*
import com.emarsys.emarsys_sdk.command.inapp.InAppIsPausedCommand
import com.emarsys.emarsys_sdk.command.inapp.InAppPauseCommand
import com.emarsys.emarsys_sdk.command.inapp.InAppResumeCommand
import com.emarsys.emarsys_sdk.command.mobileengage.TrackCustomEventCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.ClearContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.SetContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.AddTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.FetchMessagesCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.RemoveTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.push.PushSendingEnabledCommand
import com.emarsys.emarsys_sdk.command.mobileengage.push.RegisterNotificationChannelsCommand
import com.emarsys.emarsys_sdk.command.predict.*
import com.emarsys.emarsys_sdk.command.setup.InitializeCommand
import com.emarsys.emarsys_sdk.command.setup.SetupCommand
import com.emarsys.emarsys_sdk.mapper.*
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.storage.PushTokenStorage


class EmarsysCommandFactory(
        private val application: Application,
        private val pushTokenStorage: PushTokenStorage,
        private val setupCacheSharedPreferences: SharedPreferences,
        private val flutterWrapperSharedPreferences: SharedPreferences,
        private val notificationChannelFactory: NotificationChannelFactory,
        private val inboxResultMapper: InboxResultMapper,
        private val backgroundHandler: Handler,
        private val geofenceMapper: GeofenceMapper,
        private val mapToProductMapper: MapToProductMapper,
        private val recommendationLogicMapper: RecommendationLogicMapper,
        private val recommendationFilterListMapper: RecommendationFilterListMapper,
        private val productMapper: ProductMapper
) {

    fun create(methodName: String): EmarsysCommand? {
        return when (methodName) {
            "setup" -> SetupCommand(
                    application, pushTokenStorage,
                    setupCacheSharedPreferences, false
            )
            "android.setupFromCache" -> SetupCommand(
                    application, pushTokenStorage,
                    setupCacheSharedPreferences, true
            )
            "setContact" -> SetContactCommand()
            "clearContact" -> ClearContactCommand()
            "android.initialize" -> InitializeCommand(
                    flutterWrapperSharedPreferences,
                    backgroundHandler
            )
            "push.pushSendingEnabled" -> PushSendingEnabledCommand(pushTokenStorage)
            "push.android.registerNotificationChannels" -> RegisterNotificationChannelsCommand(
                    application,
                    notificationChannelFactory
            )
            "config.changeApplicationCode" -> ChangeApplicationCodeCommand(
                    setupCacheSharedPreferences
            )
            "config.changeMerchantId" -> ChangeMerchantIdCommand(setupCacheSharedPreferences)
            "config.applicationCode" -> ApplicationCodeCommand()
            "config.merchantId" -> MerchantIdCommand()
            "config.contactFieldId" -> ContactFieldIdCommand()
            "config.hardwareId" -> HardwareIdCommand()
            "config.languageCode" -> LanguageCodeCommand()
            "config.notificationSettings" -> NotificationSettingsCommand()
            "config.sdkVersion" -> SdkVersionCommand()
            "trackCustomEvent" -> TrackCustomEventCommand()
            "inbox.fetchMessages" -> FetchMessagesCommand(inboxResultMapper)
            "inbox.addTag" -> AddTagCommand()
            "inbox.removeTag" -> RemoveTagCommand()
            "geofence.enable" -> GeofenceEnableCommand()
            "geofence.disable" -> GeofenceDisableCommand()
            "geofence.initialEnterTriggerEnabled" -> GeofenceInitialEnterTriggerEnabledCommand()
            "geofence.isEnabled" -> GeofenceIsEnabledCommand()
            "geofence.registeredGeofences" -> RegisteredGeofencesCommand(geofenceMapper)
            "inApp.resume" -> InAppResumeCommand()
            "inApp.pause" -> InAppPauseCommand()
            "inApp.isPaused" -> InAppIsPausedCommand()
            "predict.trackItemView" -> TrackItemViewCommand()
            "predict.trackCategoryView" -> TrackCategoryViewCommand()
            "predict.trackTag" -> TrackTagCommand()
            "predict.trackSearchTerm" -> TrackSearchTermCommand()
            "predict.trackCart" -> TrackCartItemCommand()
            "predict.trackPurchase" -> TrackPurchaseCommand()
            "predict.trackRecommendationClick" -> TrackRecommendationClickCommand(mapToProductMapper)
            "predict.recommendProducts" -> RecommendProductsCommand(
                    logicMapper = recommendationLogicMapper,
                    filterListMapper = recommendationFilterListMapper,
                    productMapper = productMapper
            )
            else -> null
        }
    }
}