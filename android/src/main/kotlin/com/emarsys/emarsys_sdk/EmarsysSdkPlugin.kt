package com.emarsys.emarsys_sdk

import android.app.Application
import android.content.Context
import androidx.annotation.NonNull
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel


/** EmarsysSdkPlugin */
class EmarsysSdkPlugin : FlutterPlugin {
    companion object {
        private const val METHOD_CHANNEL_NAME = "com.emarsys.methods"
    }

    private var channel: MethodChannel? = null
    private val initializationLock = Any()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(
            flutterPluginBinding.applicationContext,
            flutterPluginBinding.binaryMessenger
        )
    }

    private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
        synchronized(initializationLock) {
            setupDependencyContainer(
                DefaultDependencyContainer(
                    applicationContext as Application,
                    messenger
                )
            )

            if (channel != null) {
                return
            }

            channel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
            channel!!.setMethodCallHandler(EmarsysMethodCallHandler(applicationContext))
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}
