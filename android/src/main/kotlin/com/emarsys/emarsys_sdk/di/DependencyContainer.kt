package com.emarsys.emarsys_sdk.di

import android.app.Activity
import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.flutter.InlineInAppViewFactory
import com.emarsys.emarsys_sdk.mapper.*
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.storage.CurrentActivityHolder
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import java.lang.ref.WeakReference

fun dependencyContainer() = DependencyContainer.instance
    ?: throw IllegalStateException("DependencyContainer has to be setup first!")

fun tearDownDependencyContainer() {
    DependencyContainer.instance = null
}

fun setupDependencyContainer(container: DependencyContainer) {
    if (DependencyContainer.instance == null) {
        DependencyContainer.instance = container
    }
}

fun dependencyContainerIsSetup(): Boolean {
    return DependencyContainer.instance != null
}

interface DependencyContainer {
    companion object {
        var instance: DependencyContainer? = null
    }

    val backgroundHandler: Handler

    val emarsysCommandFactory: EmarsysCommandFactory

    val application: Application

    val setupCacheSharedPreferences: SharedPreferences

    val flutterWrapperSharedPreferences: SharedPreferences

    val pushTokenStorage: PushTokenStorage

    val currentActivityHolder: CurrentActivityHolder

    val inlineInAppViewFactory: InlineInAppViewFactory

    val eventHandlerFactory: EventHandlerFactory

    val notificationChannelFactory: NotificationChannelFactory

    val inboxResultMapper: InboxResultMapper

    val mapToProductMapper: MapToProductMapper

    val recommendationLogicMapper: RecommendationLogicMapper

    val recommendationFilterListMapper: RecommendationFilterListMapper

    val productMapper: ProductMapper
}