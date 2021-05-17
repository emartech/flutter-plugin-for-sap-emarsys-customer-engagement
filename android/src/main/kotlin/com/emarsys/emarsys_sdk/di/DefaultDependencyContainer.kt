package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider

class DefaultDependencyContainer(override val application: Application) : DependencyContainer {

    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory(pushTokenStorage)
    }
    override val flutterBackgroundExecutor: FlutterBackgroundExecutor by lazy {
        FlutterBackgroundExecutor(application)
    }
    override val sharedPreferences: SharedPreferences by lazy {
        application.getSharedPreferences("flutter_wrapper", 0)
    }
    override val mainHandlerProvider: MainHandlerProvider by lazy {
        MainHandlerProvider()
    }
    override val pushTokenStorage: PushTokenStorage by lazy {
        PushTokenStorage(sharedPreferences)
    }
}