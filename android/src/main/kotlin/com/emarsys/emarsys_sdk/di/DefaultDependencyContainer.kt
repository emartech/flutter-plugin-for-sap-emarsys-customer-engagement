package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.flutter.InlineInAppViewFactory
import com.emarsys.emarsys_sdk.mapper.GeofenceMapper
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.provider.BackgroundHandlerProvider
import com.emarsys.emarsys_sdk.storage.CurrentActivityHolder
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import io.flutter.plugin.common.BinaryMessenger

class DefaultDependencyContainer(
        override val application: Application,
        private val binaryMessenger: BinaryMessenger
) : DependencyContainer {
    companion object {
        const val EMARSYS_SETUP_CACHE_SHARED_PREFERENCES = "emarsys_setup_cache"
    }

    override val backgroundHandler: Handler by lazy {
        BackgroundHandlerProvider.provide()
    }


    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory(
                application,
                pushTokenStorage,
                eventHandlerFactory,
                setupCacheSharedPreferences,
                flutterWrapperSharedPreferences,
                notificationChannelFactory,
                inboxResultMapper,
                backgroundHandler,
                GeofenceMapper()
        )
    }

    override val setupCacheSharedPreferences: SharedPreferences by lazy {
        val prefs = application.getSharedPreferences(EMARSYS_SETUP_CACHE_SHARED_PREFERENCES, 0)
        if (prefs.getString(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, null) == null &&
                prefs.getString(ConfigStorageKeys.PREDICT_MERCHANT_ID.name, null) == null &&
                prefs.getString(ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name, null) == null &&
                prefs.getString(ConfigStorageKeys.ANDROID_SHARED_SECRET.name, null) == null &&
                prefs.getString(
                        ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
                        null
                ) == null
        ) {
            flutterWrapperSharedPreferences.copyTo(prefs)
        }
        prefs
    }

    override val flutterWrapperSharedPreferences: SharedPreferences by lazy {
        application.getSharedPreferences("flutter_wrapper", 0)
    }

    override val pushTokenStorage: PushTokenStorage by lazy {
        PushTokenStorage(flutterWrapperSharedPreferences)
    }

    override val currentActivityHolder: CurrentActivityHolder by lazy {
        CurrentActivityHolder()
    }

    override val eventHandlerFactory: EventHandlerFactory by lazy {
        EventHandlerFactory(binaryMessenger)
    }

    override val inlineInAppViewFactory: InlineInAppViewFactory by lazy {
        InlineInAppViewFactory(binaryMessenger)
    }

    override val notificationChannelFactory: NotificationChannelFactory by lazy {
        NotificationChannelFactory()
    }

    override val inboxResultMapper: InboxResultMapper by lazy {
        InboxResultMapper()
    }
}

fun SharedPreferences.copyTo(dest: SharedPreferences) = with(dest.edit()) {
    for (entry in all.entries) {
        val value = entry.value ?: continue
        val key = entry.key
        when (value) {
            is String -> putString(key, value)
            is Set<*> -> putStringSet(key, value as Set<String>)
            is Int -> putInt(key, value)
            is Long -> putLong(key, value)
            is Float -> putFloat(key, value)
            is Boolean -> putBoolean(key, value)
            else -> error("Unknown value type: $value")
        }
    }
    apply()
}