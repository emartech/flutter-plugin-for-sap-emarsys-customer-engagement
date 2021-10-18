package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import java.lang.IllegalArgumentException

class ChangeMerchantIdCommand(private val sharedPreferences: SharedPreferences) :
    EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val merchantId: String? = parameters?.get("merchantId") as String?
        merchantId ?: throw IllegalArgumentException("merchantId must not be null")

        sharedPreferences.edit()
            .putString(
                ConfigStorageKeys.PREDICT_MERCHANT_ID.name, merchantId
            ).apply()
        Emarsys.config.changeMerchantId(merchantId)
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