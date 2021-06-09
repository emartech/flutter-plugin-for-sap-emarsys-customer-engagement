package com.emarsys.emarsys_sdk.flutter

import android.app.Application
import android.content.SharedPreferences
import android.content.res.AssetManager
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import java.util.concurrent.atomic.AtomicBoolean

class FlutterBackgroundExecutor(private val application: Application) {
    companion object {
        const val CALLBACK_HANDLE_KEY = "callback_handle"
        const val BACKGROUND_CHANNEL_NAME = "com.emarsys.background"
    }

    private var backgroundChannel: MethodChannel? = null
    private var backgroundFlutterEngine: FlutterEngine? = null
    private val isCallbackDispatcherReady: AtomicBoolean = AtomicBoolean(false)
    private lateinit var executor: DartExecutor

    private val isRunning: Boolean
        get() = isCallbackDispatcherReady.get()


    fun startBackgroundIsolate(callback: (DartExecutor) -> Unit) {
        if (backgroundFlutterEngine != null) {
            return
        }
        if (!isRunning) {
            MainHandlerProvider.provide().post {
                backgroundFlutterEngine = FlutterEngine(application)
                executor = backgroundFlutterEngine!!.dartExecutor
                initializeMethodChannel(executor)
                callback(executor)
            }
        }
    }

    fun awakeFlutterCallback(sharedPreferences: SharedPreferences) {
        val appBundlePath = FlutterInjector.instance().flutterLoader().findAppBundlePath()
        val assets: AssetManager = application.assets
        val callbackHandle = sharedPreferences.getLong(CALLBACK_HANDLE_KEY, 0)
        val flutterCallback =
            FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
        val dartCallback = DartExecutor.DartCallback(assets, appBundlePath, flutterCallback)
        executor.executeDartCallback(dartCallback)
    }

    private fun initializeMethodChannel(isolate: BinaryMessenger) {
        backgroundChannel = MethodChannel(
            isolate,
            BACKGROUND_CHANNEL_NAME
        ).also {
            it.setMethodCallHandler(EmarsysMethodCallHandler(application) { isRunning ->
                isCallbackDispatcherReady.set(isRunning)
            })
        }
    }
}