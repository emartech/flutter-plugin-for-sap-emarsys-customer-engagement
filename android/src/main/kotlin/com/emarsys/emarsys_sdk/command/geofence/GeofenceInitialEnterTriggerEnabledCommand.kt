package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import kotlin.IllegalArgumentException

class GeofenceInitialEnterTriggerEnabledCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val enabled: Boolean? = parameters?.get("enabled") as? Boolean
        var error: Throwable? = null
        if (enabled != null) {
            Emarsys.geofence.setInitialEnterTriggerEnabled(enabled)
        } else {
            error = IllegalArgumentException("Illegal argument: 'enabled' must not be null!")
        }

        resultCallback.invoke(null, error)
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
