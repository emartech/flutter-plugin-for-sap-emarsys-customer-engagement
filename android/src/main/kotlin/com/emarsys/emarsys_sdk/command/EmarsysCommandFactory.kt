package com.emarsys.emarsys_sdk.command

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.command.config.*
import com.emarsys.emarsys_sdk.command.mobileengage.TrackCustomEventCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.ClearContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.SetContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.AddTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.FetchMessagesCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.RemoveTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.push.PushSendingEnabledCommand
import com.emarsys.emarsys_sdk.command.mobileengage.push.RegisterNotificationChannelsCommand
import com.emarsys.emarsys_sdk.command.setup.InitializeCommand
import com.emarsys.emarsys_sdk.command.setup.SetupCommand
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.storage.PushTokenStorage


class EmarsysCommandFactory(
    private val application: Application,
    private val pushTokenStorage: PushTokenStorage,
    private val eventHandlerFactory: EventHandlerFactory,
    private val sharedPreferences: SharedPreferences,
    private val notificationChannelFactory: NotificationChannelFactory,
    private val inboxResultMapper: InboxResultMapper
) {

    fun create(methodName: String): EmarsysCommand? {
        return when (methodName) {
            "setup" -> SetupCommand(
                application, pushTokenStorage, eventHandlerFactory,
                sharedPreferences, false
            )
            "android.setupFromCache" -> SetupCommand(
                application, pushTokenStorage,
                eventHandlerFactory, sharedPreferences, true
            )
            "setContact" -> SetContactCommand()
            "clearContact" -> ClearContactCommand()
            "android.initialize" -> InitializeCommand(sharedPreferences)
            "push.pushSendingEnabled" -> PushSendingEnabledCommand(pushTokenStorage)
            "push.android.registerNotificationChannels" -> RegisterNotificationChannelsCommand(
                application,
                notificationChannelFactory
            )
            "config.changeApplicationCode" -> ChangeApplicationCodeCommand(sharedPreferences)
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
            else -> null
        }
    }
}