package com.emarsys.emarsys_sdk.commands

import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.PushTokenHolder
import com.emarsys.emarsys_sdk.di.dependencyContainer


class SetupCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val contactFieldId: Int? = parameters?.get("contactFieldId") as Int?
        if (parameters != null && contactFieldId != null) {
            val configBuild = EmarsysConfig.Builder()
                    .application(dependencyContainer().application)
                    .contactFieldId(contactFieldId)

            if (parameters.containsKey("mobileEngageApplicationCode")) {
                configBuild.mobileEngageApplicationCode(parameters["mobileEngageApplicationCode"] as String?)
            }
            if (parameters.containsKey("predictMerchantId")) {
                configBuild.predictMerchantId(parameters["predictMerchantId"] as String?)
            }
            val androidDisableAutomaticPushTokenSending = parameters["androidDisableAutomaticPushTokenSending"] as Boolean?
            if (androidDisableAutomaticPushTokenSending != null && androidDisableAutomaticPushTokenSending) {
                configBuild.disableAutomaticPushTokenSending()
            }
            if (parameters.containsKey("androidSharedPackageNames")) {
                configBuild.sharedPackageNames(parameters["androidSharedPackageNames"] as List<String>)
            }
            if (parameters.containsKey("androidSharedSecret")) {
                configBuild.sharedSecret(parameters["androidSharedSecret"] as String)
            }
            if (parameters.containsKey("androidVerboseConsoleLoggingEnabled") && parameters["androidVerboseConsoleLoggingEnabled"] as Boolean) {
                configBuild.enableVerboseConsoleLogging()
            }
            Emarsys.setup(configBuild.build())
            if (androidDisableAutomaticPushTokenSending == null || !androidDisableAutomaticPushTokenSending) {
                if (PushTokenHolder.pushToken != null) {
                    Emarsys.push.pushToken = PushTokenHolder.pushToken
                } else {
                    PushTokenHolder.pushTokenObserver = { pushToken ->
                        pushToken?.let { Emarsys.push.pushToken = it }
                    }
                }
            }
        } else {
            throw IllegalArgumentException("ContactFieldId must not be null!")
        }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        return true
    }

    override fun hashCode(): Int {
        return javaClass.hashCode()
    }
}