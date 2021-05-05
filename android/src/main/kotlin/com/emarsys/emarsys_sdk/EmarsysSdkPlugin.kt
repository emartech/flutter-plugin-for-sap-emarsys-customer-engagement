package com.emarsys.emarsys_sdk

import android.app.Application
import androidx.annotation.NonNull
import com.emarsys.emarsys_sdk.di.DefaultDependencyContainer
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.core.di.DependencyContainer
import com.emarsys.core.di.DependencyInjection
import com.emarsys.di.DefaultEmarsysDependencyContainer

/** EmarsysSdkPlugin */
class EmarsysSdkPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupDependencyContainer(DefaultDependencyContainer(flutterPluginBinding.applicationContext as Application))

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.emarsys.methods")
        channel.setMethodCallHandler(this)

        DependencyInjection.setup(DefaultEmarsysDependencyContainer(EmarsysConfig.Builder().build()))
    }

    @Suppress("UNCHECKED_CAST")
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.arguments is Map<*, *>?) {
            val command = dependencyContainer().emarsysCommandFactory.create(call.method)
            command?.execute(call.arguments as Map<String, Any>?) { success: Map<String, Any>?, error: Throwable? ->
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
        channel.setMethodCallHandler(null)
    }
}
