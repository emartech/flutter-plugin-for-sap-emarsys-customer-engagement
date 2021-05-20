package com.emarsys.emarsys_sdk.commands

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.EventHandlerFactory
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys


class SetupCommand(
    private val application: Application,
    private val pushTokenStorage: PushTokenStorage,
    private val eventHandlerFactory: EventHandlerFactory,
    private val sharedPreferences: SharedPreferences,
    private val fromCache: Boolean
) : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val configBuilder = if (fromCache) {
            configFromSharedPref()
        } else {
            configFromParameters(parameters)
        }

        Emarsys.setup(configBuilder.build())
        if (pushTokenStorage.enabled) {
            if (pushTokenStorage.pushToken != null) {
                Emarsys.push.pushToken = pushTokenStorage.pushToken
            } else {
                pushTokenStorage.pushTokenObserver = { pushToken ->
                    pushToken?.let { Emarsys.push.pushToken = it }
                }
            }
        }

        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.PUSH)
            .apply { Emarsys.push.setNotificationEventHandler(this) }
        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.SILENT_PUSH)
            .apply { Emarsys.push.setSilentMessageEventHandler(this) }

        resultCallback(null, null)
    }


    private fun configFromSharedPref(): EmarsysConfig.Builder {
        val contactFieldId = sharedPreferences.getInt(ConfigStorageKeys.CONTACT_FIELD_ID.name, 0)
        val appCode =
            sharedPreferences.getString(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, null)
        val merchantId =
            sharedPreferences.getString(ConfigStorageKeys.PREDICT_MERCHANT_ID.name, null)
        val disableAutomaticPushSending = sharedPreferences.getBoolean(
            ConfigStorageKeys.ANDROID_DISABLE_AUTOMATIC_PUSH_TOKEN_SENDING.name,
            false
        )
        val sharedPackages = sharedPreferences.getStringSet(
            ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name,
            mutableSetOf()
        )
        val secret = sharedPreferences.getString(ConfigStorageKeys.ANDROID_SHARED_SECRET.name, null)
        val enableVerboseLogging = sharedPreferences.getBoolean(
            ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
            false
        )

        val builder = EmarsysConfig.Builder()
            .application(application)
            .contactFieldId(contactFieldId)
            .mobileEngageApplicationCode(appCode)
            .predictMerchantId(merchantId)
        if (disableAutomaticPushSending) {
            builder.disableAutomaticPushTokenSending()
        }
        if (enableVerboseLogging) {
            builder.enableVerboseConsoleLogging()
        }
        if (!sharedPackages.isNullOrEmpty()) {
            builder.sharedPackageNames(sharedPackages.toList())
        }
        if (secret != null) {
            builder.sharedSecret(secret)
        }

        return builder
    }

    private fun configFromParameters(parameters: Map<String, Any?>?): EmarsysConfig.Builder {
        val configBuilder = EmarsysConfig.Builder()
        val sharedPreferencesEdit = sharedPreferences.edit()
        val contactFieldId: Int? = parameters?.get("contactFieldId") as Int?
        if (parameters != null && contactFieldId != null) {
            sharedPreferencesEdit.putInt(
                ConfigStorageKeys.CONTACT_FIELD_ID.name,
                contactFieldId
            )
            val configBuild = configBuilder
                .application(application)
                .contactFieldId(contactFieldId)

            (parameters["applicationCode"] as String?).let {
                configBuild.mobileEngageApplicationCode(it)
                sharedPreferencesEdit.putString(
                    ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                    it
                )
            }

            (parameters["merchantId"] as String?).let {
                configBuild.predictMerchantId(it)
                sharedPreferencesEdit.putString(
                    ConfigStorageKeys.PREDICT_MERCHANT_ID.name,
                    it
                )
            }

            (parameters["androidSharedPackageNames"] as List<String>?)?.let {
                configBuild.sharedPackageNames(parameters["androidSharedPackageNames"] as List<String>)
                sharedPreferencesEdit.putStringSet(
                    ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name,
                    it?.let { packageNames -> mutableSetOf(*packageNames.toTypedArray()) }
                )
            }

            (parameters["androidSharedSecret"] as String?)?.let {
                configBuild.sharedSecret(parameters["androidSharedSecret"] as String)
                sharedPreferencesEdit.putString(
                    ConfigStorageKeys.ANDROID_SHARED_SECRET.name,
                    it
                )
            }

            ((parameters["androidVerboseConsoleLoggingEnabled"] as Boolean?) ?: false).let {
                if (it) {
                    configBuild.enableVerboseConsoleLogging()
                }
                sharedPreferencesEdit.putBoolean(
                    ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
                    it
                )
            }
            sharedPreferencesEdit.apply()
        } else {
            throw IllegalArgumentException("ContactFieldId must not be null!")
        }
        return configBuilder
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