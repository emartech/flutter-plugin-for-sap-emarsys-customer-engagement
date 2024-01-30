package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.storage.PushTokenStorage

class PushSendingEnabledCommand(private val pushTokenStorage: PushTokenStorage) : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val pushSendingEnabled = (parameters?.get("pushSendingEnabled") as? Boolean)
        if (pushSendingEnabled != null) {
            handlePushToken(pushSendingEnabled, resultCallback)
        } else {
            resultCallback(null, IllegalArgumentException("pushSendingEnabled must not be null"))
        }
    }

    private fun handlePushToken(
        enable: Boolean,
        resultCallback: ResultCallback
    ) {
        if (enable) {
            val pushToken = pushTokenStorage.pushToken
            if (pushToken != null) {
                Emarsys.push.setPushToken(pushTokenStorage.pushToken!!) {
                    resultCallback.invoke(null, it)
                }
            } else {
                resultCallback.invoke(null, IllegalArgumentException("PushToken must not be null"))
            }
        } else {
            Emarsys.push.clearPushToken {
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