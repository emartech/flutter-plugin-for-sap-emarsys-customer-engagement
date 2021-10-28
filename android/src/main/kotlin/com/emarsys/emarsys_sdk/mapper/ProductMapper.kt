package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.Product

class ProductMapper : Mapper<Product, Map<String, Any?>> {
    override fun map(input: Product): Map<String, Any?> {
        return mutableMapOf(
            "productId" to input.productId,
            "title" to input.title,
            "linkUrlString" to input.linkUrl,
            "feature" to input.feature,
            "cohort" to input.cohort,
            "customFields" to input.customFields,
            "imageUrlString" to input.imageUrl.toString(),
            "zoomImageUrlString" to input.zoomImageUrl.toString(),
            "categoryPath" to input.categoryPath,
            "available" to input.available,
            "productDescription" to input.productDescription,
            "price" to input.price,
            "msrp" to input.msrp,
            "album" to input.album,
            "actor" to input.actor,
            "artist" to input.artist,
            "author" to input.author,
            "brand" to input.brand,
            "year" to input.year
        )
    }
}