package com.emarsys.emarsys_sdk.commands

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.EventHandlerFactory
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.commands.config.*
import com.emarsys.emarsys_sdk.commands.push.PushSendingEnabledCommand


class EmarsysCommandFactory(
    private val application: Application,
    private val pushTokenStorage: PushTokenStorage,
    private val eventHandlerFactory: EventHandlerFactory,
    private val sharedPreferences: SharedPreferences
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
            "config.applicationCode" -> ApplicationCodeCommand()
            "config.merchantId" -> MerchantIdCommand()
            "config.contactFieldId" -> ContactFieldIdCommand()
            "config.hardwareId" -> HardwareIdCommand()
            "config.languageCode" -> LanguageCodeCommand()
            "config.notificationSettings" -> NotificationSettingsCommand()
            "config.sdkVersion" -> SdkVersionCommand()
            else -> null
        }
    }
}