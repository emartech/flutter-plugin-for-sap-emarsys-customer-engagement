package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.flutter.InlineInAppViewFactory
import com.emarsys.emarsys_sdk.mapper.*
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.provider.BackgroundHandlerProvider
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.emarsys_sdk.storage.CurrentActivityHolder
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import com.emarsys.mobileengage.api.event.EventHandler
import io.flutter.plugin.common.BinaryMessenger

class DefaultDependencyContainer(
        override val application: Application,
        binaryMessenger: BinaryMessenger
) : DependencyContainer {
    companion object {
        const val EMARSYS_SETUP_CACHE_SHARED_PREFERENCES = "emarsys_setup_cache"
    }

    override var messenger: BinaryMessenger = binaryMessenger
        set(value) {
            field = value
            initEventChannels()
        }

    private lateinit var preparedEventHandlerFactory: EventHandlerFactory
    private lateinit var preparedPushEventHandler: EventHandler
    private lateinit var preparedSilentPushEventHandler: EventHandler
    private lateinit var preparedGeofenceEventHandler: EventHandler
    private lateinit var preparedInAppEventHandler: EventHandler

    init {
        initEventChannels()
    }

    fun initEventChannels() {
        preparedEventHandlerFactory = EventHandlerFactory(messenger)
        preparedPushEventHandler = preparedEventHandlerFactory.create(EventHandlerFactory.EventChannelName.PUSH)
        preparedSilentPushEventHandler = preparedEventHandlerFactory.create(EventHandlerFactory.EventChannelName.SILENT_PUSH)
        preparedGeofenceEventHandler = preparedEventHandlerFactory.create(EventHandlerFactory.EventChannelName.GEOFENCE)
        preparedInAppEventHandler = preparedEventHandlerFactory.create(EventHandlerFactory.EventChannelName.INAPP)
    }

    override val backgroundHandler: Handler by lazy {
        BackgroundHandlerProvider.provide()
    }

    override val uiHandler: Handler by lazy {
        MainHandlerProvider.provide()
    }

    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory(
                application,
                pushTokenStorage,
                setupCacheSharedPreferences,
                flutterWrapperSharedPreferences,
                notificationChannelFactory,
                inboxResultMapper,
                backgroundHandler,
                GeofenceMapper(),
                mapToProductMapper,
                recommendationLogicMapper,
                recommendationFilterListMapper,
                productMapper
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

    override val inlineInAppViewFactory: InlineInAppViewFactory by lazy {
        InlineInAppViewFactory(messenger)
    }
    override val eventHandlerFactory: EventHandlerFactory
        get() = preparedEventHandlerFactory

    override val notificationChannelFactory: NotificationChannelFactory by lazy {
        NotificationChannelFactory()
    }

    override val inboxResultMapper: InboxResultMapper by lazy {
        InboxResultMapper()
    }
    override val mapToProductMapper: MapToProductMapper by lazy {
        MapToProductMapper()
    }
    override val recommendationLogicMapper: RecommendationLogicMapper by lazy {
        RecommendationLogicMapper()
    }
    override val recommendationFilterListMapper: RecommendationFilterListMapper by lazy {
        RecommendationFilterListMapper()
    }
    override val productMapper: ProductMapper by lazy {
        ProductMapper()
    }
    override val pushEventHandler: EventHandler
        get() = preparedPushEventHandler
    override val silentPushEventHandler: EventHandler
        get() = preparedSilentPushEventHandler
    override val geofenceEventHandler: EventHandler
        get() = preparedGeofenceEventHandler
    override val inAppEventHandler: EventHandler
        get() = preparedInAppEventHandler
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