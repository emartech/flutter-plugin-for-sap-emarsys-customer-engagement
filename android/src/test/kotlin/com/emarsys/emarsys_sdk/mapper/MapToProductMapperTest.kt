package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.Product
import io.kotlintest.shouldBe
import org.junit.Before
import org.junit.Test

class MapToProductMapperTest {
    private lateinit var mapper: MapToProductMapper

    @Before
    fun setUp() {
        mapper = MapToProductMapper()
    }

    @Test
    fun testMap_shouldReturnProduct() {
        val expected = Product(
            productId = "test_productId",
            title = "test_title",
            linkUrl = "http://lifestylelabels.com/lsl-men-polo-shirt-se16.html",
            feature = "test_feature",
            cohort = "test_cohort",
            categoryPath = "test_categoryPath",
            available = true,
            msrp = 45.6f,
            price = 12.3f,
            imageUrlString = "http://lifestylelabels.com/pub/media/catalog/product/m/p/mp001.jpg",
            zoomImageUrlString = "http://lifestylelabels.com/pub/media/catalog/product/m/p/mp001.jpg",
            productDescription = "test_productDescription",
            album = "test_album",
            actor = "test_actor",
            artist = "test_artist",
            author = "test_author",
            brand = "test_brand",
            year = 2000,
            customFields = mapOf("field1" to "value1", "field2" to "value2")
        )

        val input = mapOf(
            "productId" to "test_productId",
            "title" to "test_title",
            "linkUrl" to "http://lifestylelabels.com/lsl-men-polo-shirt-se16.html",
            "feature" to "test_feature",
            "cohort" to "test_cohort",
            "customFields" to mapOf("field1" to "value1", "field2" to "value2"),
            "imageUrlString" to "http://lifestylelabels.com/pub/media/catalog/product/m/p/mp001.jpg",
            "zoomImageUrlString" to "http://lifestylelabels.com/pub/media/catalog/product/m/p/mp001.jpg",
            "categoryPath" to "test_categoryPath",
            "available" to true,
            "productDescription" to "test_productDescription",
            "price" to 12.3f,
            "msrp" to 45.6f,
            "album" to "test_album",
            "actor" to "test_actor",
            "artist" to "test_artist",
            "author" to "test_author",
            "brand" to "test_brand",
            "year" to 2000
        )

        val result = mapper.map(input)

        result shouldBe expected
    }

    @Test
    fun testMap_shouldReturnProductWithNulls() {
        val expected = Product(
            productId = "test_productId",
            title = "test_title",
            linkUrl = "http://lifestylelabels.com/lsl-men-polo-shirt-se16.html",
            feature = "test_feature",
            cohort = "test_cohort",
            customFields = mapOf("field1" to "value1", "field2" to "value2")
        )
        val input = mapOf(
            "productId" to "test_productId",
            "title" to "test_title",
            "linkUrl" to "http://lifestylelabels.com/lsl-men-polo-shirt-se16.html",
            "feature" to "test_feature",
            "cohort" to "test_cohort",
            "customFields" to mapOf("field1" to "value1", "field2" to "value2")
        )

        val result = mapper.map(input)

        result shouldBe expected
    }
}