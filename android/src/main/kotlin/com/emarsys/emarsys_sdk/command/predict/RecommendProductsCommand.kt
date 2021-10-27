package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.core.api.result.Try
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.mapper.ProductMapper
import com.emarsys.emarsys_sdk.mapper.RecommendationFilterListMapper
import com.emarsys.emarsys_sdk.mapper.RecommendationLogicMapper
import com.emarsys.predict.api.model.Product

class RecommendProductsCommand(
    private val logicMapper: RecommendationLogicMapper,
    private val filterListMapper: RecommendationFilterListMapper,
    private val productMapper: ProductMapper
) : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        requireNotNull(parameters)
        requireNotNull(parameters["logic"])

        val logicMap: Map<String, Any> = parameters["logic"] as Map<String, Any>
        val filterListMap: List<Map<String, Any?>>? =
            parameters["recommendationFilter"] as List<Map<String, Any>>?
        val limit: Int? = parameters["limit"] as Int?
        val availabilityZone: String? = parameters["availabilityZone"] as String?

        val onResult: (Try<List<Product>>) -> Unit = {
            val resultMapList = it.result?.map(productMapper::map)
            resultCallback.invoke(
                resultMapList, it.errorCause
            )
        }

        val filters = if (filterListMap != null) filterListMapper.map(filterListMap) else listOf()

        if (limit != null && filters.isNotEmpty() && availabilityZone != null) {
            Emarsys.predict.recommendProducts(
                logicMapper.map(logicMap),
                filters,
                limit,
                availabilityZone,
                onResult
            )
        } else if (filters.isNotEmpty() && availabilityZone != null) {
            Emarsys.predict.recommendProducts(
                logicMapper.map(logicMap),
                filters,
                availabilityZone,
                onResult
            )
        } else if (filters.isNotEmpty() && limit != null) {
            Emarsys.predict.recommendProducts(logicMapper.map(logicMap), filters, limit, onResult)
        } else if (limit != null && availabilityZone != null) {
            Emarsys.predict.recommendProducts(
                logicMapper.map(logicMap),
                limit,
                availabilityZone,
                onResult
            )
        } else if (availabilityZone != null) {
            Emarsys.predict.recommendProducts(logicMapper.map(logicMap), availabilityZone, onResult)
        } else if (limit != null) {
            Emarsys.predict.recommendProducts(logicMapper.map(logicMap), limit, onResult)
        } else if (filters.isNotEmpty()) {
            Emarsys.predict.recommendProducts(logicMapper.map(logicMap), filters, onResult)
        } else {
            Emarsys.predict.recommendProducts(logicMapper.map(logicMap), onResult)
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