package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys

class ChangeApplicationCodeCommand(private val sharedPreferences: SharedPreferences) :
    EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val applicationCode = parameters?.get("applicationCode") as String?
        if (applicationCode != null) {
            Emarsys.config.changeApplicationCode(applicationCode) {
                if (it == null) {
                    sharedPreferences.edit().putString(
                            ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, applicationCode
                        ).apply()
                } else {
                    sharedPreferences.edit()
                        .remove(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name).apply()
                }
                resultCallback.invoke(null, it)
            }
        } else {
            resultCallback(null, IllegalArgumentException("applicationCode must not be null"))
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