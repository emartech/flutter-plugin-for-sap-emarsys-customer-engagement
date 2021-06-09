package com.emarsys.emarsys_sdk.command.setup

import android.content.SharedPreferences
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor

class InitializeCommand(private val sharedPreferences: SharedPreferences) : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val callbackHandle: Long? = parameters?.get("callbackHandle") as Long?

        if (callbackHandle != null) {
            sharedPreferences.edit()
                .putLong(FlutterBackgroundExecutor.CALLBACK_HANDLE_KEY, callbackHandle).apply()
        }
        resultCallback.invoke(null, null)
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        return true
    }

    override fun hashCode(): Int {
        return javaClass.hashCode()
    }
}