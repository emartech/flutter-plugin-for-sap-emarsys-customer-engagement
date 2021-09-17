package com.emarsys.emarsys_sdk

import android.app.Application
import android.content.Context
import androidx.annotation.NonNull
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.flutter.EmarsysMethodCallHandler
import com.emarsys.emarsys_sdk.flutter.InlineInAppViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference

class EmarsysSdkPlugin : FlutterPlugin, ActivityAware {
    companion object {
        private const val METHOD_CHANNEL_NAME = "com.emarsys.methods"
    }

    private var channel: MethodChannel? = null
    private val initializationLock = Any()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val applicationContext = flutterPluginBinding.applicationContext
        val messenger = flutterPluginBinding.binaryMessenger

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

            flutterPluginBinding
                .platformViewRegistry
                .registerViewFactory(
                    "inlineInAppView",
                    dependencyContainer().inlineInAppViewFactory
                )
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        dependencyContainer().currentActivityHolder.currentActivity =
            WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        dependencyContainer().currentActivityHolder.currentActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        dependencyContainer().currentActivityHolder.currentActivity =
            WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        dependencyContainer().currentActivityHolder.currentActivity = null
    }
}
