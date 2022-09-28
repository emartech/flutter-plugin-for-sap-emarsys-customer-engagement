package com.emarsys.emarsys_sdk.api

import android.app.Application
import android.content.Context
import com.emarsys.Emarsys
import com.emarsys.config.ConfigLoader
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainerIsSetup
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.service.EmarsysFirebaseMessagingServiceUtils
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import java.util.*

class EmarsysFirebaseMessagingService : FirebaseMessagingService() {
    companion object {
        private val configLoader = ConfigLoader()

        private val messageQueue: MutableList<RemoteMessage> =
            Collections.synchronizedList(LinkedList())

        fun showInitialMessages(context: Context) {
            if (isEmarsysComponentSetup()) {
                handleMessageQueue(context)
            } else {
                Emarsys.setup(
                    configLoader.loadConfigFromSharedPref(
                        context.applicationContext as Application,
                        "emarsys_setup_cache"
                    ).build()
                )
                handleMessageQueue(context)
            }
        }

        private fun handleMessageQueue(context: Context) {
            synchronized(messageQueue) {
                messageQueue.forEach {
                    EmarsysFirebaseMessagingServiceUtils.handleMessage(context, it)
                }
                messageQueue.clear()
            }
        }
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        if (!isEmarsysComponentSetup()) {
            initFlutterEngine {
                MainHandlerProvider.provide().post {
                    it.awakeFlutterCallback(dependencyContainer().flutterWrapperSharedPreferences)
                }
            }
        }
        synchronized(messageQueue) {
            messageQueue.add(message)
        }
        showInitialMessages(this)
    }

    override fun onNewToken(pushToken: String) {
        super.onNewToken(pushToken)
        initFlutterEngine {
            dependencyContainer().pushTokenStorage.pushToken = pushToken
        }
    }

    private fun initFlutterEngine(onCompleted: (FlutterBackgroundExecutor) -> Unit) {
        val executor = FlutterBackgroundExecutor(application)
        executor.startBackgroundIsolate { dartExecutor ->
            if (dependencyContainerIsSetup()) {
                dependencyContainer().messenger = dartExecutor
            } else {
                setupDependencyContainer(DefaultDependencyContainer(application, dartExecutor))
            }
            onCompleted.invoke(executor)
        }
    }
}