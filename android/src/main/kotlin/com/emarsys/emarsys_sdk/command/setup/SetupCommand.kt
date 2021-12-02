package com.emarsys.emarsys_sdk.command.setup

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.common.feature.InnerFeature
import com.emarsys.config.ConfigLoader
import com.emarsys.config.EmarsysConfig
import com.emarsys.core.activity.ActivityLifecycleAction
import com.emarsys.core.feature.FeatureRegistry
import com.emarsys.core.provider.wrapper.WrapperInfoContainer
import com.emarsys.di.emarsys
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer.Companion.EMARSYS_SETUP_CACHE_SHARED_PREFERENCES
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
            ConfigLoader().loadConfigFromSharedPref(
                application,
                EMARSYS_SETUP_CACHE_SHARED_PREFERENCES
            )
        } else {
            configFromParameters(parameters)
        }

        val setupHasBeenCalledPreviously = isEmarsysComponentSetup()
        Emarsys.setup(configBuilder.build())
        FeatureRegistry.enableFeature(InnerFeature.APP_EVENT_CACHE)

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
        if (dependencyContainer().currentActivityHolder.currentActivity != null) {
            emarsys().currentActivityProvider.set(dependencyContainer().currentActivityHolder.currentActivity?.get())
            emarsys().activityLifecycleActionRegistry.execute(
                dependencyContainer().currentActivityHolder.currentActivity?.get(),
                listOf(
                    ActivityLifecycleAction.ActivityLifecycle.CREATE,
                    ActivityLifecycleAction.ActivityLifecycle.RESUME
                )
            )
        } else {
            dependencyContainer().currentActivityHolder.currentActivityObserver =
                { currentActivity ->
                    emarsys().currentActivityProvider.set(currentActivity?.get())
                    emarsys().activityLifecycleActionRegistry.execute(
                        currentActivity?.get(),
                        listOf(
                            ActivityLifecycleAction.ActivityLifecycle.CREATE,
                            ActivityLifecycleAction.ActivityLifecycle.RESUME
                        )
                    )
                }
        }

        if (!fromCache) {
            eventHandlerFactory.create(EventHandlerFactory.EventChannelName.PUSH)
                .apply { Emarsys.push.setNotificationEventHandler(this) }
            eventHandlerFactory.create(EventHandlerFactory.EventChannelName.SILENT_PUSH)
                .apply { Emarsys.push.setSilentMessageEventHandler(this) }
            eventHandlerFactory.create(EventHandlerFactory.EventChannelName.GEOFENCE)
                .apply { Emarsys.geofence.setEventHandler(this) }
            eventHandlerFactory.create(EventHandlerFactory.EventChannelName.INAPP)
                .apply { Emarsys.inApp.setEventHandler(this) }
        }
        resultCallback(null, null)
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