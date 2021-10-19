package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.predict.api.model.PredictCartItem

class TrackCartItemCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val items: List<Map<String, Any>>? = parameters?.get("items") as List<Map<String, Any>>?
        items ?: throw IllegalArgumentException("items should not be null!")

        Emarsys.predict.trackCart(
            items.map {
                PredictCartItem(
                    it["itemId"] as String,
                    it["price"] as Double,
                    it["quantity"] as Double
                )
            })

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