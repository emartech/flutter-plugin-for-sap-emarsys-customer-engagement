package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.event.EventHandlerFactory
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import io.mockk.mockk

class FakeDependencyContainer(
    override val application: Application = mockk(relaxed = true),
    override val emarsysCommandFactory: EmarsysCommandFactory = mockk(relaxed = true),
    override val sharedPreferences: SharedPreferences = mockk(relaxed = true),
    override val pushTokenStorage: PushTokenStorage = mockk(relaxed = true),
    override val eventHandlerFactory: EventHandlerFactory = mockk(relaxed = true),
    override val notificationChannelFactory: NotificationChannelFactory = mockk(relaxed = true),
    override val inboxResultMapper: InboxResultMapper = mockk(relaxed = true),
    override val backgroundHandler: Handler = mockk(relaxed = true)
) : DependencyContainer