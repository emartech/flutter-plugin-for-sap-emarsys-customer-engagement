package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.storage.PushTokenStorage

class SetPushTokenCommand(private val pushTokenStorage: PushTokenStorage) : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val newPushToken: String = (parameters?.get("pushToken") as? String)
                ?: throw IllegalArgumentException("pushToken must not be null")
        val pushToken = pushTokenStorage.pushToken
        if (pushToken != newPushToken) {
            pushTokenStorage.pushToken = newPushToken
            Emarsys.push.setPushToken(newPushToken) {
                resultCallback.invoke(null, it)
            }
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