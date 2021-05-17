package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider

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

interface DependencyContainer {
    companion object {
        var instance: DependencyContainer? = null
    }

    val emarsysCommandFactory: EmarsysCommandFactory

    val application: Application

    val flutterBackgroundExecutor: FlutterBackgroundExecutor

    val sharedPreferences: SharedPreferences

    val mainHandlerProvider: MainHandlerProvider

    val pushTokenStorage: PushTokenStorage
}