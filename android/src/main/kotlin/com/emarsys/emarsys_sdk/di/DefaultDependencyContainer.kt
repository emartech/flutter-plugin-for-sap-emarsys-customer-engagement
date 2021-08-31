package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.provider.BackgroundHandlerProvider
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import io.flutter.plugin.common.BinaryMessenger

class DefaultDependencyContainer(
    override val application: Application,
    private val binaryMessenger: BinaryMessenger
) : DependencyContainer {
    override val backgroundHandler: Handler by lazy {
        BackgroundHandlerProvider.provide()
    }


    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory(
            application,
            pushTokenStorage,
            eventHandlerFactory,
            sharedPreferences,
            notificationChannelFactory,
            inboxResultMapper
        )
    }
    override val sharedPreferences: SharedPreferences by lazy {
        application.getSharedPreferences("flutter_wrapper", 0)
    }
    override val pushTokenStorage: PushTokenStorage by lazy {
        PushTokenStorage(sharedPreferences)
    }
    override val eventHandlerFactory: EventHandlerFactory by lazy {
        EventHandlerFactory(binaryMessenger)
    }
    override val notificationChannelFactory: NotificationChannelFactory by lazy {
        NotificationChannelFactory()
    }

    override val inboxResultMapper: InboxResultMapper by lazy {
        InboxResultMapper()
    }
}