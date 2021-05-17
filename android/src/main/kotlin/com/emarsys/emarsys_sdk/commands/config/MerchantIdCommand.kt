package com.emarsys.emarsys_sdk.commands.config

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.commands.ResultCallback

class MerchantIdCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        resultCallback.invoke(Emarsys.config.merchantId, null)
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