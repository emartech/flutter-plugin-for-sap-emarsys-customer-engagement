package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import io.mockk.mockk

class FakeDependencyContainer(
    override val application: Application = mockk(relaxed = true),
    override val emarsysCommandFactory: EmarsysCommandFactory = mockk(relaxed = true),
    override val flutterBackgroundExecutor: FlutterBackgroundExecutor = mockk(relaxed = true),
    override val sharedPreferences: SharedPreferences = mockk(relaxed = true),
    override val mainHandlerProvider: MainHandlerProvider = mockk(relaxed = true)
) : DependencyContainer