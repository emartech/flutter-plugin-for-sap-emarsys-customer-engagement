package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import java.lang.IllegalArgumentException

class ChangeApplicationCodeCommand(private val sharedPreferences: SharedPreferences) :
    EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val applicationCode: String? = parameters?.get("applicationCode") as String?
        applicationCode ?: throw IllegalArgumentException("applicationCode must not be null")

        Emarsys.config.changeApplicationCode(applicationCode) {
            if (it == null) {
                sharedPreferences.edit()
                    .putString(
                        ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name, applicationCode
                    ).apply()
            } else {
                sharedPreferences.edit()
                    .remove(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name)
                    .apply()
            }
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