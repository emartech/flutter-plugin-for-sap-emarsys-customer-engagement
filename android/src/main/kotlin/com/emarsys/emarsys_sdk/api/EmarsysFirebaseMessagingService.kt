package com.emarsys.emarsys_sdk.api

import android.content.Context
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.service.EmarsysFirebaseMessagingServiceUtils
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import java.util.*

class EmarsysFirebaseMessagingService : FirebaseMessagingService() {
    companion object {
        private val messageQueue: MutableList<RemoteMessage> =
            Collections.synchronizedList(LinkedList())

        fun showInitialMessages(context: Context) {
            if (isEmarsysComponentSetup()) {
                synchronized(messageQueue) {
                    messageQueue.forEach {
                        EmarsysFirebaseMessagingServiceUtils.handleMessage(context, it)
                    }
                    messageQueue.clear()
                }
            }
        }
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        if (!isEmarsysComponentSetup()) {
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