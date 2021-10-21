package com.emarsys.emarsys_sdk.di

import android.app.Activity
import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.flutter.InlineInAppViewFactory
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.mapper.MapToProductMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.storage.CurrentActivityHolder
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import io.mockk.mockk
import java.lang.ref.WeakReference

class FakeDependencyContainer(
        override val application: Application = mockk(relaxed = true),
        override val emarsysCommandFactory: EmarsysCommandFactory = mockk(relaxed = true),
        override val pushTokenStorage: PushTokenStorage = mockk(relaxed = true),
        override val eventHandlerFactory: EventHandlerFactory = mockk(relaxed = true),
        override val notificationChannelFactory: NotificationChannelFactory = mockk(relaxed = true),
        override val inboxResultMapper: InboxResultMapper = mockk(relaxed = true),
        override val backgroundHandler: Handler = mockk(relaxed = true),
        override val inlineInAppViewFactory: InlineInAppViewFactory = mockk(relaxed = true),
        override val currentActivityHolder: CurrentActivityHolder = mockk(relaxed = true),
        override val setupCacheSharedPreferences: SharedPreferences = mockk(relaxed = true),
        override val flutterWrapperSharedPreferences: SharedPreferences = mockk(relaxed = true),
        override val mapToProductMapper: MapToProductMapper = mockk(relaxed = true)
) : DependencyContainer