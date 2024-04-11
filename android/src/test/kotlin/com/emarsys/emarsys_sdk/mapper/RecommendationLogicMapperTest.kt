package com.emarsys.emarsys_sdk.mapper

import arrow.core.mapOf
import com.emarsys.predict.api.model.CartItem
import com.emarsys.predict.api.model.Logic
import com.emarsys.predict.api.model.PredictCartItem
import com.emarsys.predict.api.model.RecommendationLogic
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After

import org.junit.Before
import org.junit.Test

class RecommendationLogicMapperTest {
    private lateinit var mapper: RecommendationLogicMapper
    private lateinit var mockLogic: Logic

    @Before
    fun setUp() {
        mockkStatic("com.emarsys.predict.api.model.RecommendationLogic")
        mockLogic = mockk()
        mapper = RecommendationLogicMapper()
    }

    @After
    fun tearDown() {
        unmockkStatic(RecommendationLogic::class)
    }

    @Test(expected = IllegalArgumentException::class)
    fun test_mapShouldThrowException() {
        mapper.map(mapOf())
    }

    @Test(expected = IllegalArgumentException::class)
    fun test_mapShouldThrowException_whenNameIsMissing() {
        mapper.map(
            mapOf(
                "data" to emptyMap<String, Any>(),
                "variants" to emptyList<String>()
            )
        )
    }

    @Test(expected = IllegalArgumentException::class)
    fun test_mapShouldThrowException_whenDataIsMissing() {
        mapper.map(
            mapOf(
                "name" to "testName",
                "variants" to emptyList<String>()
            )
        )
    }

    @Test(expected = IllegalArgumentException::class)
    fun test_mapShouldThrowException_whenVariantsIsMissing() {
        mapper.map(
            mapOf(
                "name" to "testName",
                "data" to emptyMap<String, Any>(),
            )
        )
    }

    @Test
    fun testMap_shouldMapSearchLogic() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.SEARCH,
                "data" to mapOf("searchTerm" to "testSearchTerm"),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.SEARCH
        result.data shouldBe mapOf("q" to "testSearchTerm")
    }

    @Test
    fun testMap_shouldMapSearchLogic_withoutSearchTerm() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.SEARCH,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.SEARCH
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapCartLogic() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.CART,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.CART
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapCartLogic_WithItems() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.CART,
                "data" to mapOf<String, Any>(
                    "cartItems" to listOf(
                        mapOf(
                            "itemId" to "testItemId1",
                            "price" to 123,
                            "quantity" to 234
                        ), mapOf(
                            "itemId" to "testItemId2",
                            "price" to 456,
                            "quantity" to 567
                        )
                    )
                ),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.CART
        result.data.containsKey("ca") shouldBe true
    }

    @Test
    fun testMap_shouldMapSearchCategory() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.CATEGORY,
                "data" to mapOf("categoryPath" to "testCategoryPath"),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.CATEGORY
        result.data shouldBe mapOf("vc" to "testCategoryPath")
    }

    @Test
    fun testMap_shouldMapCategoryLogic_withoutCategoryPath() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.CATEGORY,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.CATEGORY
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapRelatedLogic_withRelatedItemId() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.RELATED,
                "data" to mapOf("itemId" to "testItemId"),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.RELATED
        result.data shouldBe mapOf("v" to "i:testItemId")
    }

    @Test
    fun testMap_shouldMapRelatedLogic_withoutRelatedItemId() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.RELATED,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.RELATED
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapAlsoBoughtLogic_withRelatedItemId() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.ALSO_BOUGHT,
                "data" to mapOf("itemId" to "testItemId"),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.ALSO_BOUGHT
        result.data shouldBe mapOf("v" to "i:testItemId")
    }

    @Test
    fun testMap_shouldMapAlsoBoughtLogic_withoutRelatedItemId() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.ALSO_BOUGHT,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.ALSO_BOUGHT
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapPopularLogic_withCategoryPath() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.POPULAR,
                "data" to mapOf("categoryPath" to "testCategoryPath"),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.POPULAR
        result.data shouldBe mapOf("vc" to "testCategoryPath")
    }

    @Test
    fun testMap_shouldMapPopularLogic_withoutCategoryPath() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.POPULAR,
                "data" to mapOf<String, Any>(),
                "variants" to emptyList<String>()
            )
        )

        result.logicName shouldBe RecommendationLogic.POPULAR
        result.data shouldBe mapOf()
    }

    @Test
    fun testMap_shouldMapPersonalLogic_withVariants() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.PERSONAL,
                "data" to mapOf<String, Any>(),
                "variants" to listOf("testVariant1", "testVariant2")
            )
        )

        result.logicName shouldBe RecommendationLogic.PERSONAL
        result.variants shouldBe listOf("testVariant1", "testVariant2")
    }

    @Test
    fun testMap_shouldMapPersonalLogic_withNullAsVariants() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.PERSONAL,
                "data" to mapOf<String, Any>(),
                "variants" to null
            )
        )

        result.logicName shouldBe RecommendationLogic.PERSONAL
        result.variants shouldBe emptyList()
    }

    @Test
    fun testMap_shouldMapHomeLogic_withVariants() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.HOME,
                "data" to mapOf<String, Any>(),
                "variants" to listOf("testVariant1", "testVariant2")
            )
        )

        result.logicName shouldBe RecommendationLogic.HOME
        result.variants shouldBe listOf("testVariant1", "testVariant2")
    }

    @Test
    fun testMap_shouldMapHomeLogic_withNullAsVariants() {
        val result = mapper.map(
            mapOf(
                "name" to RecommendationLogic.HOME,
                "data" to mapOf<String, Any>(),
                "variants" to null
            )
        )

        result.logicName shouldBe RecommendationLogic.HOME
        result.variants shouldBe emptyList()
    }
}