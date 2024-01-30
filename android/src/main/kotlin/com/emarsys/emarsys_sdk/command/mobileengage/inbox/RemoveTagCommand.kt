package com.emarsys.emarsys_sdk.command.mobileengage.inbox

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class RemoveTagCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val messageId = parameters?.get("messageId") as? String
        val tag = parameters?.get("tag") as? String

        if (messageId != null && tag != null) {
            Emarsys.messageInbox.removeTag(tag, messageId) {
                resultCallback.invoke(null, it)
            }
        } else {
            resultCallback(null, IllegalArgumentException("tag and messageId must not be null"))
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