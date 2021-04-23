package com.emarsys.emarsys_sdk.commands

import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.EmarsysCommand
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
            if (parameters.containsKey("androidAutomaticPushTokenSending") && !(parameters["androidAutomaticPushTokenSending"] as Boolean)) {
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