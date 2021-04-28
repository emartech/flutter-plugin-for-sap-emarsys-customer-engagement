package com.emarsys.emarsys_sdk.commands

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.EmarsysCommand


class ClearContactCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        Emarsys.clearContact(CompletionListener {
            resultCallback.invoke(null, it)
        })
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