package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.commands.config.*
import com.emarsys.emarsys_sdk.commands.push.PushSendingEnabledCommand


class EmarsysCommandFactory(private val pushTokenStorage: PushTokenStorage) {

    fun create(methodName: String): EmarsysCommand? {
        return when (methodName) {
            "setup" -> SetupCommand(pushTokenStorage)
            "setContact" -> SetContactCommand()
            "clearContact" -> ClearContactCommand()
            "android.initialize" -> InitializeCommand()
            "push.pushSendingEnabled" -> PushSendingEnabledCommand(pushTokenStorage)
            "config.applicationCode" -> ApplicationCodeCommand()
            "config.merchantId" -> MerchantIdCommand()
            "config.contactFieldId" -> ContactFieldIdCommand()
            "config.hardwareId" -> HardwareIdCommand()
            "config.languageCode" -> LanguageCodeCommand()
            "config.pushSettings" -> PushSettingsCommand()
            "config.sdkVersion" -> SdkVersionCommand()
            else -> null
        }
    }
}