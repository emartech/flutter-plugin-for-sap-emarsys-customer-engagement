package com.emarsys.emarsys_sdk.command.mobileengage.contact

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class SetContactCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val contactFieldValue = parameters?.get("contactFieldValue") as? String
        val contactFieldId = parameters?.get("contactFieldId") as? Int
        if (contactFieldId != null && contactFieldValue != null) {
            Emarsys.setContact(contactFieldId, contactFieldValue) {
                resultCallback.invoke(null, it)
            }
        } else {
            resultCallback(
                null,
                IllegalArgumentException("contactFieldId and contactFieldValue must not be null")
            )
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