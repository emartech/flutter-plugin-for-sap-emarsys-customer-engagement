package com.emarsys.emarsys_sdk

import android.content.Context
import com.emarsys.core.di.DependencyInjection
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
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
        setupDependencyContainer(DefaultDependencyContainer(application))
        dependencyContainer().mainHandlerProvider.provide().post {
            if (!DependencyInjection.isSetup()) {
                dependencyContainer().flutterBackgroundExecutor.startBackgroundIsolate()
            }
        }

        synchronized(messageQueue) {
            messageQueue.add(message)
        }
        showInitialMessages(this)
    }

    override fun onNewToken(pushToken: String) {
        super.onNewToken(pushToken)
        setupDependencyContainer(DefaultDependencyContainer(application))
        dependencyContainer().pushTokenStorage.pushToken = pushToken
    }
}