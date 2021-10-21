package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class TrackTagCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val eventName: String? = parameters?.get("eventName") as String?
        eventName ?: throw IllegalArgumentException("eventName should not be null!")

        val attributes: Map<String, String>? = parameters?.get("attributes") as Map<String, String>?

        Emarsys.predict.trackTag(eventName, attributes)

        resultCallback.invoke(null, null)
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