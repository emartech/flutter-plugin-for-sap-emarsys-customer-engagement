package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.mapper.MapToProductMapper

class TrackRecommendationClickCommand(private val mapToProductMapper: MapToProductMapper) :
    EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val productMap: Map<String, Any>? = parameters?.get("product") as Map<String, Any>?
        productMap ?: throw IllegalArgumentException("product should not be null!")
        val product = mapToProductMapper.map(productMap)

        Emarsys.predict.trackRecommendationClick(product)

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