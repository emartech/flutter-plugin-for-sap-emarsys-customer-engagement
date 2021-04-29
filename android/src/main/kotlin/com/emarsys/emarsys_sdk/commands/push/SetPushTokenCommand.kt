package com.emarsys.emarsys_sdk.commands.push

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.commands.ResultCallback

class SetPushTokenCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val pushToken: String? = parameters?.get("pushToken") as? String
        if (pushToken != null) {
            Emarsys.push.setPushToken(pushToken) {
                resultCallback.invoke(null, it)
            }
        } else {
            throw IllegalArgumentException("PushToken must not be null!")
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