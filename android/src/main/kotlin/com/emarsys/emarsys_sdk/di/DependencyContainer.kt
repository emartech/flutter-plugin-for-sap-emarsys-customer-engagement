package com.emarsys.emarsys_sdk.di

import android.app.Activity
import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
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

    var flutterActivity: WeakReference<Activity?>?

    val backgroundHandler: Handler

    val emarsysCommandFactory: EmarsysCommandFactory

    val application: Application

    val sharedPreferences: SharedPreferences

    val pushTokenStorage: PushTokenStorage

    val eventHandlerFactory: EventHandlerFactory

    val notificationChannelFactory: NotificationChannelFactory

    val inboxResultMapper: InboxResultMapper
}