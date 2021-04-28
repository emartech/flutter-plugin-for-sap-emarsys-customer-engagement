package com.emarsys.emarsys_sdk.commands

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.EmarsysCommand

class SetContactCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val contactFieldValue = parameters?.get("contactFieldValue") as? String
        if (contactFieldValue != null) {
            Emarsys.setContact(contactFieldValue, CompletionListener {
                resultCallback.invoke(null, it)
            })
        } else {
            throw IllegalArgumentException("ContactFieldValue must not be null")
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