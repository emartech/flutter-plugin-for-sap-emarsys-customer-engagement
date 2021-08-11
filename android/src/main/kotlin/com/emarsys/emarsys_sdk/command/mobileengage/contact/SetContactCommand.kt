package com.emarsys.emarsys_sdk.command.mobileengage.contact

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class SetContactCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val contactFieldValue = parameters?.get("contactFieldValue") as? String
        val contactFieldId = parameters?.get("contactFieldId") as? Int
        contactFieldId ?: throw IllegalArgumentException("contactFieldId must not be null")
        contactFieldValue ?: throw IllegalArgumentException("contactFieldValue must not be null")

        Emarsys.setContact(contactFieldId, contactFieldValue) {
            resultCallback.invoke(null, it)
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