package com.emarsys.emarsys_sdk.api

import android.content.Context
import com.emarsys.core.di.DependencyInjection
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.service.EmarsysMessagingServiceUtils
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import java.util.*

class EmarsysMessagingService : FirebaseMessagingService() {
    companion object {
        private val messageQueue: MutableList<RemoteMessage> =
            Collections.synchronizedList(LinkedList())

        fun showInitialMessages(context: Context) {
            if (DependencyInjection.isSetup()) {
                synchronized(messageQueue) {
                    messageQueue.forEach {
                        EmarsysMessagingServiceUtils.handleMessage(context, it)
                    }
                    messageQueue.clear()
                }
            }
        }
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        if (!DependencyInjection.isSetup()) {
            initFlutterEngine().apply {
                MainHandlerProvider.provide().post {
                    awakeFlutterCallback(dependencyContainer().sharedPreferences)
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
        initFlutterEngine()
        dependencyContainer().pushTokenStorage.pushToken = pushToken
    }

    private fun initFlutterEngine(): FlutterBackgroundExecutor {
        return FlutterBackgroundExecutor(application).apply {
            startBackgroundIsolate { dartExecutor ->
                setupDependencyContainer(DefaultDependencyContainer(application, dartExecutor))
            }
        }
    }
}