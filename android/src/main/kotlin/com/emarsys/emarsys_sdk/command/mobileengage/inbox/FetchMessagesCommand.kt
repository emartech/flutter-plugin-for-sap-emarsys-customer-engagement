package com.emarsys.emarsys_sdk.command.mobileengage.inbox

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.mobileengage.api.inbox.InboxResult

class FetchMessagesCommand(private val inboxResultMapper: InboxResultMapper) : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {

        Emarsys.messageInbox.fetchMessages { result ->
            if (result.errorCause != null) {
                resultCallback.invoke(null, result.errorCause)
                return@fetchMessages
            }
            resultCallback.invoke((inboxResultMapper.map(result.result as InboxResult)), null)
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