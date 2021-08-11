package com.emarsys.emarsys_sdk.command.mobileengage

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import java.lang.IllegalArgumentException

class TrackCustomEventCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val eventName: String? = parameters?.get("eventName") as String?
        eventName ?: throw IllegalArgumentException("eventName should not be null!")

        val eventAttributes: Map<String, String>? =
            parameters?.get("eventAttributes") as Map<String, String>?

        Emarsys.trackCustomEvent(eventName, eventAttributes) {
            resultCallback.invoke(null, it)
        }
    }
}