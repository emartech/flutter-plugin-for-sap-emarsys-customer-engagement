package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.Product
import io.kotlintest.shouldBe

import org.junit.Before
import org.junit.Test

class ProductMapperTest {
    private lateinit var mapper: ProductMapper

    @Before
    fun setup() {
        mapper = ProductMapper()
    }

 @Test
 fun test_mapShouldMapProductFieldCorrectly() {
     val testProduct = Product(
         productId = "testId",
                  title = "testTitle",
                  linkUrl = "testUrl",
                  feature = "testFeature",
                  cohort = "testCohort",
                  customFields = mapOf("key1" to "value1", "key2" to "value2"),
                  imageUrlString = "https://emarsys.com",
                  zoomImageUrlString = "https://emarsys.com",
                  categoryPath = "testPath",
                  available = false,
                  productDescription = "testDescription",
                  price = 123f,
                  msrp = 567f,
                  album = "testAlbum",
                  actor = "testActor",
                  artist = "testArtist",
                  author = "testAuthor",
                  brand = "testBrand",
                  year = 2000
     )

     val result = mapper.map(testProduct)

     result["productId"] shouldBe "testId"
     result["title"] shouldBe "testTitle"
     result["linkUrl"] shouldBe "testUrl"
     result["feature"] shouldBe "testFeature"
     result["cohort"] shouldBe "testCohort"
     result["customFields"] shouldBe mapOf("key1" to "value1", "key2" to "value2")
     result["imageUrlString"] shouldBe "https://emarsys.com"
     result["zoomImageUrlString"] shouldBe "https://emarsys.com"
     result["categoryPath"] shouldBe "testPath"
     result["available"] shouldBe false
     result["productDescription"] shouldBe "testDescription"
     result["price"] shouldBe 123f
     result["msrp"] shouldBe 567f
     result["album"] shouldBe "testAlbum"
     result["actor"] shouldBe "testActor"
     result["artist"] shouldBe "testArtist"
     result["author"] shouldBe "testAuthor"
     result["brand"] shouldBe "testBrand"
     result["year"] shouldBe 2000

 }
}