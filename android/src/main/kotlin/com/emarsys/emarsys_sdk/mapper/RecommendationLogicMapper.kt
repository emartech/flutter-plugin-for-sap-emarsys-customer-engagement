package com.emarsys.emarsys_sdk.mapper

import com.emarsys.core.Mapper
import com.emarsys.predict.api.model.CartItem
import com.emarsys.predict.api.model.Logic
import com.emarsys.predict.api.model.PredictCartItem
import com.emarsys.predict.api.model.RecommendationLogic
import java.lang.IllegalArgumentException

class RecommendationLogicMapper : Mapper<Map<String, Any?>, Logic> {

    override fun map(input: Map<String, Any?>): Logic {
        val logicName =
            input["name"] as String? ?: throw IllegalArgumentException("Name should not be empty!")
        val data = input["data"] as Map<String, Any>?
            ?: throw IllegalArgumentException("Data should not be empty!")
        val variants = input["variants"] as List<String>?

        return when (logicName) {
            RecommendationLogic.SEARCH ->
                if (data["searchTerm"] != null) {
                    RecommendationLogic.search(data["searchTerm"] as String)
                } else {
                    RecommendationLogic.search()
                }
            RecommendationLogic.CART ->
                if (data["cartItems"] != null) {
                    RecommendationLogic.cart(mapCartItems(data["cartItems"] as List<Map<String, Any>>))
                } else {
                    RecommendationLogic.cart()
                }
            RecommendationLogic.CATEGORY ->
                if (data["categoryPath"] != null) {
                    RecommendationLogic.category(data["categoryPath"] as String)
                } else {
                    RecommendationLogic.category()
                }
            RecommendationLogic.RELATED ->
                if (data["itemId"] != null) {
                    RecommendationLogic.related(data["itemId"] as String)
                } else {
                    RecommendationLogic.related()
                }
            RecommendationLogic.ALSO_BOUGHT ->
                if (data["itemId"] != null) {
                    RecommendationLogic.alsoBought(data["itemId"] as String)
                } else {
                    RecommendationLogic.alsoBought()
                }
            RecommendationLogic.POPULAR ->
                if (data["categoryPath"] != null) {
                    RecommendationLogic.popular(data["categoryPath"] as String)
                } else {
                    RecommendationLogic.popular()
                }
            RecommendationLogic.PERSONAL ->
                if (variants != null) {
                    RecommendationLogic.personal(variants)
                } else {
                    RecommendationLogic.personal(listOf())
                }
            RecommendationLogic.HOME ->
                if (variants != null) {
                    RecommendationLogic.home(variants)
                } else {
                    RecommendationLogic.home(listOf())
                }
            else -> throw IllegalArgumentException("Invalid logic name!")
        }
    }

    private fun mapCartItems(cartItems: List<Map<String, Any>>): List<CartItem> {
        return cartItems.map {
            PredictCartItem(
                it["itemId"] as String,
                it["price"] as Double,
                it["quantity"] as Double
            )
        }.toList()
    }
}