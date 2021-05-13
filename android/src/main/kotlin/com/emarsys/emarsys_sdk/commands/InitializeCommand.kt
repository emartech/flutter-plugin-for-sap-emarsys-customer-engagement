package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.FlutterBackgroundExecutor

class InitializeCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val callbackHandle: Long? = parameters?.get("callbackHandle") as Long?

        if (callbackHandle != null) {
            FlutterBackgroundExecutor.setCallbackDispatcher(callbackHandle)
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