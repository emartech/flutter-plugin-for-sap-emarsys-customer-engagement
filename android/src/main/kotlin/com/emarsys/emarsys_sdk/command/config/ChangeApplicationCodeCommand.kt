package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.dependencyContainer
import androidx.core.content.edit

class ChangeApplicationCodeCommand(private val sharedPreferences: SharedPreferences) :
    EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val applicationCode = parameters?.get("applicationCode") as String?
        if (applicationCode != null) {
            Emarsys.config.changeApplicationCode(applicationCode) {
                if (it == null) {
                    sharedPreferences.edit {
                        putString(
                            ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, applicationCode
                        )
                    }
                    registerEventHandlers()
                } else {
                    sharedPreferences.edit {
                        remove(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name)
                    }
                }
                resultCallback.invoke(null, it)
            }
        } else {
            resultCallback(null, IllegalArgumentException("applicationCode must not be null"))
        }
    }

    private fun registerEventHandlers() {
        Emarsys.push.setNotificationEventHandler(dependencyContainer().pushEventHandler)
        Emarsys.push.setSilentMessageEventHandler(dependencyContainer().silentPushEventHandler)
        Emarsys.inApp.setEventHandler(dependencyContainer().inAppEventHandler)
        Emarsys.geofence.setEventHandler(dependencyContainer().geofenceEventHandler)
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