package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class SetPushTokenCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val pushToken: String? = (parameters?.get("pushToken") as? String)

        if (!pushToken.isNullOrEmpty()) {
            Emarsys.push.setPushToken(pushToken) {
                resultCallback.invoke(null, it)
            }
        } else {
            throw IllegalArgumentException("pushToken must not be null or empty!")
        }
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