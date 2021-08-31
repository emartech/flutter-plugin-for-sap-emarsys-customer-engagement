package com.emarsys.emarsys_sdk.command.setup

import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.flutter.FlutterBackgroundExecutor

class InitializeCommand(
    private val sharedPreferences: SharedPreferences,
    private val backgroundHandler: Handler
) : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val callbackHandle: Long? = parameters?.get("callbackHandle") as Long?
        backgroundHandler.post {
            if (callbackHandle != null) {
                sharedPreferences.edit()
                    .putLong(FlutterBackgroundExecutor.CALLBACK_HANDLE_KEY, callbackHandle).commit()
            }
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