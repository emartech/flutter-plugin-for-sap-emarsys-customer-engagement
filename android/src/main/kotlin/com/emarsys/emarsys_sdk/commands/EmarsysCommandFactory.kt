package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.commands.config.*
import com.emarsys.emarsys_sdk.commands.push.ClearPushTokenCommand
import com.emarsys.emarsys_sdk.commands.push.SetPushTokenCommand


class EmarsysCommandFactory {

    fun create(methodName: String): EmarsysCommand? {
        return when (methodName) {
            "setup" -> SetupCommand()
            "setContact" -> SetContactCommand()
            "clearContact" -> ClearContactCommand()
            "android.initialize" -> InitializeCommand()
            "push.clearPushToken" -> ClearPushTokenCommand()
            "push.setPushToken" -> SetPushTokenCommand()
            "config.applicationCode" -> ApplicationCodeCommand()
            "config.merchantId" -> MerchantIdCommand()
            "config.contactFieldId" -> ContactFieldIdCommand()
            "config.hardwareId" -> HardwareIdCommand()
            "config.languageCode" -> LanguageCodeCommand()
            "config.pushSettings" -> PushSettingsCommand()
            "config.sdkVersion" -> SdkVersionCommand()
            "config.android.isAutomaticPushSendingEnabled" -> IsAutomaticPushSendingEnabledCommand()
            else -> null
        }
    }
}