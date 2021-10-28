package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.Product

class MapToProductMapper : Mapper<Map<String, Any>, Product> {

    override fun map(productMap: Map<String, Any>): Product {
        return Product(
            productId = productMap["productId"] as String,
            title = productMap["title"] as String,
            linkUrl = productMap["linkUrlString"] as String,
            feature = productMap["feature"] as String,
            cohort = productMap["cohort"] as String,
            customFields = productMap["customFields"] as Map<String, String?>,
            imageUrlString = productMap["imageUrlString"] as String?,
            zoomImageUrlString = productMap["zoomImageUrlString"] as String?,
            categoryPath = productMap["categoryPath"] as String?,
            available = productMap["available"] as Boolean?,
            productDescription = productMap["productDescription"] as String?,
            price = (productMap["price"] as Double?)?.toFloat(),
            msrp = (productMap["msrp"] as Double?)?.toFloat(),
            album = productMap["album"] as String?,
            actor = productMap["actor"] as String?,
            artist = productMap["artist"] as String?,
            author = productMap["author"] as String?,
            brand = productMap["brand"] as String?,
            year = productMap["year"] as Int?,
        )
    }
}