package com.emarsys.emarsys_sdk.flutter

import android.app.Application
import android.os.Handler
import com.emarsys.emarsys_sdk.api.EmarsysFirebaseMessagingService
import com.emarsys.emarsys_sdk.api.EmarsysHuaweiMessagingService
import com.emarsys.emarsys_sdk.di.dependencyContainer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class EmarsysMethodCallHandler(
    private val application: Application,
    private val onInitialized: (Boolean) -> Unit = {},
    private val uiHandler: Handler
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.arguments is Map<*, *>?) {
            val command = dependencyContainer().emarsysCommandFactory.create(call.method)
            command?.execute(call.arguments as Map<String, Any>?) { success: Any?, error: Throwable? ->
                if (error != null) {
                    uiHandler.post {
                        result.error("EMARSYS_SDK_ERROR", error.message, error)
                    }
                } else {
                    onInitialized(call.method)
                    uiHandler.post {
                        result.success(success)
                    }
                }
            } ?: result.notImplemented()
        } else {
            throw IllegalArgumentException("Call arguments is not a map!")
        }
    }

    private fun onInitialized(methodName: String?) {
        if (methodName == "android.setupFromCache") {
            onInitialized(true)
            EmarsysFirebaseMessagingService.showInitialMessages(application)
            EmarsysHuaweiMessagingService.showInitialMessages(application)
        }
    }

}