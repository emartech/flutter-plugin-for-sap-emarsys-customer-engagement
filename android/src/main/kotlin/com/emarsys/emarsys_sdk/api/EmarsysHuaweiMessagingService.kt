package com.emarsys.emarsys_sdk.api

import android.content.Context
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainerIsSetup
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.service.EmarsysHuaweiMessagingServiceUtils
import com.huawei.hms.push.HmsMessageService
import com.huawei.hms.push.RemoteMessage
import java.util.*

class EmarsysHuaweiMessagingService : HmsMessageService() {

    companion object {
        private val messageQueue: MutableList<RemoteMessage> =
                Collections.synchronizedList(LinkedList())

        fun showInitialMessages(context: Context) {
            if (isEmarsysComponentSetup()) {
                synchronized(messageQueue) {
                    messageQueue.forEach {
                        EmarsysHuaweiMessagingServiceUtils.handleMessage(context, it)
                    }
                    messageQueue.clear()
                }
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