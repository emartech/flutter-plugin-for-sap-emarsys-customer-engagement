package com.emarsys.emarsys_sdk

import android.app.Application
import android.content.res.AssetManager
import android.util.Log
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.dependencyContainer
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor.DartCallback
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.view.FlutterCallbackInformation
import java.util.concurrent.atomic.AtomicBoolean

class FlutterBackgroundExecutor(private val application: Application) : MethodCallHandler {
    companion object {
        private const val CALLBACK_HANDLE_KEY = "callback_handle"
        fun setCallbackDispatcher(callbackHandle: Long) {
            dependencyContainer().sharedPreferences.edit().putLong(CALLBACK_HANDLE_KEY, callbackHandle).apply()
        }
    }

    private var backgroundChannel: MethodChannel? = null
    private var backgroundFlutterEngine: FlutterEngine? = null
    private val isCallbackDispatcherReady: AtomicBoolean = AtomicBoolean(false)

    private val isRunning: Boolean
        get() = isCallbackDispatcherReady.get()

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        try {
            if (method == "android.setupFromCache") {
                Emarsys.setup(
                    configFromSharedPref()
                )
                onInitialized()
                result.success(true)
            } else {
                result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("error", "error: " + e.message, null)
        }
    }

    fun startBackgroundIsolate() {
        if (backgroundFlutterEngine != null) {
            Log.e("EMARSYS", "Background isolate already started")
            return
        }
        if (!isRunning) {
            val callbackHandle = dependencyContainer().sharedPreferences.getLong(CALLBACK_HANDLE_KEY, 0)
            val appBundlePath = FlutterInjector.instance().flutterLoader().findAppBundlePath()
            val assets: AssetManager = application.assets
            backgroundFlutterEngine = FlutterEngine(application)

            val flutterCallback =
                FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)

            val executor = backgroundFlutterEngine!!.dartExecutor
            initializeMethodChannel(executor)
            val dartCallback = DartCallback(assets, appBundlePath, flutterCallback)
            executor.executeDartCallback(dartCallback)
        }
    }

    private fun onInitialized() {
        isCallbackDispatcherReady.set(true)
        EmarsysMessagingService.showInitialMessages(application)
    }

    private fun initializeMethodChannel(isolate: BinaryMessenger) {
        backgroundChannel = MethodChannel(
            isolate,
            "com.emarsys.background"
        ).also { it.setMethodCallHandler(this) }
    }

    private fun configFromSharedPref() : EmarsysConfig {
        val sharedPreferences = dependencyContainer().sharedPreferences
        val contactFieldId = sharedPreferences.getInt(ConfigStorageKeys.CONTACT_FIELD_ID.name, 0)
        val appCode = sharedPreferences.getString(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, null)
        val merchantId = sharedPreferences.getString(ConfigStorageKeys.PREDICT_MERCHANT_ID.name, null)
        val disableAutomaticPushSending = sharedPreferences.getBoolean(ConfigStorageKeys.ANDROID_DISABLE_AUTOMATIC_PUSH_TOKEN_SENDING.name, false)
        val sharedPackages = sharedPreferences.getStringSet(ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name, mutableSetOf())
        val secret = sharedPreferences.getString(ConfigStorageKeys.ANDROID_SHARED_SECRET.name, null)
        val enableVerboseLogging = sharedPreferences.getBoolean(ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name, false)

        val builder = EmarsysConfig.Builder()
            .application(application)
            .contactFieldId(contactFieldId)
            .mobileEngageApplicationCode(appCode)
            .predictMerchantId(merchantId)
        if (disableAutomaticPushSending) {
            builder.disableAutomaticPushTokenSending()
        }
        if (enableVerboseLogging) {
            builder.enableVerboseConsoleLogging()
        }
        if (!sharedPackages.isNullOrEmpty()) {
            builder.sharedPackageNames(sharedPackages.toList())
        }
        if (secret != null) {
            builder.sharedSecret(secret)
        }

        return builder.build()
    }
}