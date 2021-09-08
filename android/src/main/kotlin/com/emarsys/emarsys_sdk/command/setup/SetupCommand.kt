package com.emarsys.emarsys_sdk.command.setup

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.core.provider.wrapper.WrapperInfoContainer
import com.emarsys.di.emarsys
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.storage.PushTokenStorage


class SetupCommand(
        private val application: Application,
        private val pushTokenStorage: PushTokenStorage,
        private val eventHandlerFactory: EventHandlerFactory,
        private val sharedPreferences: SharedPreferences,
        private val fromCache: Boolean
) : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        WrapperInfoContainer.wrapperInfo = "flutter"
        val configBuilder = if (fromCache) {
            configFromSharedPref()
        } else {
            configFromParameters(parameters)
        }

        val setupHasBeenCalledPreviously = isEmarsysComponentSetup()
        Emarsys.setup(configBuilder.build())
        if (!setupHasBeenCalledPreviously) {
            Emarsys.trackCustomEvent("wrapper:init", mapOf("type" to "flutter"))
        }
        if (pushTokenStorage.enabled) {
            if (pushTokenStorage.pushToken != null) {
                Emarsys.push.pushToken = pushTokenStorage.pushToken
            } else {
                pushTokenStorage.pushTokenObserver = { pushToken ->
                    pushToken?.let { Emarsys.push.pushToken = it }
                }
            }
        }

        emarsys().currentActivityProvider.set(dependencyContainer().flutterActivity?.get())

        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.PUSH)
                .apply { Emarsys.push.setNotificationEventHandler(this) }
        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.SILENT_PUSH)
                .apply { Emarsys.push.setSilentMessageEventHandler(this) }
        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.GEOFENCE)
                .apply { Emarsys.geofence.setEventHandler(this) }
        eventHandlerFactory.create(EventHandlerFactory.EventChannelName.INAPP)
                .apply { Emarsys.inApp.setEventHandler(this) }
        
        resultCallback(null, null)
    }


    private fun configFromSharedPref(): EmarsysConfig.Builder {
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
                .applicationCode(appCode)
                .merchantId(merchantId)
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
        if (parameters != null) {
            val configBuild = configBuilder
                    .application(application)

            (parameters["applicationCode"] as String?).let {
                configBuild.applicationCode(it)
                sharedPreferencesEdit.putString(
                        ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                        it
                )
            }

            (parameters["merchantId"] as String?).let {
                configBuild.merchantId(it)
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
            throw IllegalArgumentException("parameterMap must not be null!")
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