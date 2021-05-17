package com.emarsys.emarsys_sdk

import android.app.Application
import android.content.Context
import androidx.annotation.NonNull
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** EmarsysSdkPlugin */
class EmarsysSdkPlugin : FlutterPlugin, MethodCallHandler {
    private var channel: MethodChannel? = null
    private val initializationLock = Any()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(
            flutterPluginBinding.applicationContext,
            flutterPluginBinding.binaryMessenger
        )
    }

    private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger?) {
        synchronized(initializationLock) {
            setupDependencyContainer(DefaultDependencyContainer(applicationContext as Application))

            if (channel != null) {
                return
            }

            channel = MethodChannel(messenger, "com.emarsys.methods")
            channel!!.setMethodCallHandler(this)
        }
    }

    @Suppress("UNCHECKED_CAST")
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.arguments is Map<*, *>?) {
            val command = dependencyContainer().emarsysCommandFactory.create(call.method)
            command?.execute(call.arguments as Map<String, Any>?) { success: Any?, error: Throwable? ->
                if (error != null) {
                    result.error("EMARSYS_SDK_ERROR", error.message, error)
                } else {
                    result.success(success)
                }
            } ?: result.notImplemented()
        } else {
            throw IllegalArgumentException("Call arguments is not a map!")
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}
