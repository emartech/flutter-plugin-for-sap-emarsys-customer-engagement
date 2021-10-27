package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.core.api.result.ResultListener
import com.emarsys.core.api.result.Try
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.mapper.ProductMapper
import com.emarsys.emarsys_sdk.mapper.RecommendationFilterListMapper
import com.emarsys.emarsys_sdk.mapper.RecommendationLogicMapper
import com.emarsys.predict.Predict
import com.emarsys.predict.api.model.*
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After

import org.junit.Before
import org.junit.Test
import java.lang.Exception

class RecommendProductsCommandTest {
    private lateinit var command: EmarsysCommand
    private lateinit var mockLogic: Logic
    private lateinit var mockFilter: RecommendationFilter
    private lateinit var mockRecommendationLogicMapper: RecommendationLogicMapper
    private lateinit var mockRecommendationFilterListMapper: RecommendationFilterListMapper
    private lateinit var mockProductMapper: ProductMapper


    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        mockLogic = mockk()
        mockFilter = mockk()
        mockProductMapper = mockk()
        mockRecommendationLogicMapper = mockk {
            every { map(any()) } returns mockLogic
        }
        mockRecommendationFilterListMapper = mockk {
            every { map(any()) } returns listOf(mockFilter)
        }
        command = RecommendProductsCommand(
            mockRecommendationLogicMapper,
            mockRecommendationFilterListMapper,
            mockProductMapper
        )
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldNotCallMethodOnEmarsys_withoutLogic() {
        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.recommendProducts(any(), any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldNotCallMethodOnEmarsys_withNull() {
        command.execute(null) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.recommendProducts(any(), any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogic() {
        every { Emarsys.predict.recommendProducts(any(), any()) } just Runs

        val parametersMap = mapOf<String, Any>("logic" to mapOf<String, Any>())

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicOnlyIfRecommendationFilterListIsEmpty() {
        every {
            Emarsys.predict.recommendProducts(
                any(),
                any()
            )
        } just Runs

        val parametersMap = mapOf("logic" to mapOf<String, Any>())

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndLimit() {
        every { Emarsys.predict.recommendProducts(any(), any<Int>(), any()) } just Runs

        val parametersMap = mapOf("logic" to mapOf<String, Any>(), "limit" to 4)

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), 4, any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndAvailabilityZone() {
        every { Emarsys.predict.recommendProducts(any(), any<String>(), any()) } just Runs

        val parametersMap = mapOf("logic" to mapOf<String, Any>(), "availabilityZone" to "testZone")

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), "testZone", any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndLimitAndAvailabilityZone() {
        every { Emarsys.predict.recommendProducts(any(), any<Int>(), any(), any()) } just Runs

        val parametersMap =
            mapOf("logic" to mapOf<String, Any>(), "limit" to 2, "availabilityZone" to "testZone")

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), 2, "testZone", any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndFilter() {
        every {
            Emarsys.predict.recommendProducts(
                any(),
                any<List<RecommendationFilter>>(),
                any()
            )
        } just Runs

        val parametersMap = mapOf(
            "logic" to mapOf<String, Any>(),
            "recommendationFilter" to listOf<Map<String, Any>>()
        )

        command.execute(parametersMap) { _, _ ->
        }

        verify { Emarsys.predict.recommendProducts(eq(mockLogic), eq(listOf(mockFilter)), any()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndFilterAndAvailabilityZone() {
        every {
            Emarsys.predict.recommendProducts(
                any(),
                any<List<RecommendationFilter>>(),
                any<String>(),
                any()
            )
        } just Runs

        val parametersMap = mapOf(
            "logic" to mapOf<String, Any>(),
            "recommendationFilter" to listOf<Map<String, Any>>(),
            "availabilityZone" to "testZone"
        )

        command.execute(parametersMap) { _, _ ->
        }

        verify {
            Emarsys.predict.recommendProducts(
                eq(mockLogic),
                eq(listOf(mockFilter)),
                "testZone",
                any()
            )
        }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndFilterAndLimit() {
        every { Emarsys.predict.recommendProducts(any(), any(), any<Int>(), any()) } just Runs

        val parametersMap = mapOf(
            "logic" to mapOf<String, Any>(),
            "recommendationFilter" to listOf<Map<String, Any>>(),
            "limit" to 5
        )

        command.execute(parametersMap) { _, _ ->
        }

        verify {
            Emarsys.predict.recommendProducts(
                eq(mockLogic),
                eq(listOf(mockFilter)),
                5,
                any()
            )
        }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withLogicAndFilterAndLimitAndAvailabilityZone() {
        every { Emarsys.predict.recommendProducts(any(), any(), any(), any(), any()) } just Runs

        val parametersMap = mapOf(
            "logic" to mapOf<String, Any>(),
            "recommendationFilter" to listOf<Map<String, Any>>(),
            "limit" to 5,
            "availabilityZone" to "testZone"
        )

        command.execute(parametersMap) { _, _ ->
        }

        verify {
            Emarsys.predict.recommendProducts(
                eq(mockLogic),
                eq(listOf(mockFilter)),
                5,
                "testZone",
                any()
            )
        }
    }

    @Test
    fun testExecute_shouldInvokeResultListener_onSuccess() {
        val mockProduct: Product = mockk()
        every { Emarsys.predict.recommendProducts(any(), any()) } just Runs
        every { mockProductMapper.map(mockProduct) } returns mapOf("1" to "2")
        every {
            Emarsys.predict.recommendProducts(
                any(),
                any(),
                any(),
                any(),
                any()
            )
        } answers { call ->
            (call.invocation.args[4] as ResultListener<Try<List<Product>>>).onResult(
                Try.success(
                    listOf(
                        mockProduct
                    )
                )
            )
        }

        val parametersMap = mapOf("logic" to mapOf<String, Any>())

        command.execute(parametersMap) { success, error ->
            success shouldBe listOf(mapOf<String, Any>("1" to "2"))
            error shouldBe null
        }

        verify {
            Emarsys.predict.recommendProducts(eq(mockLogic), any())
        }
    }

    @Test
    fun testExecute_shouldInvokeResultListener_onError() {
        val mockException: Exception = mockk()
        every { Emarsys.predict.recommendProducts(any(), any()) } just Runs
        every {
            Emarsys.predict.recommendProducts(
                any(),
                any(),
                any(),
                any(),
                any()
            )
        } answers { call ->
            (call.invocation.args[4] as ResultListener<Try<List<Product>>>).onResult(
                Try.failure(
                    mockException
                )
            )
        }

        val parametersMap = mapOf("logic" to mapOf<String, Any>())

        command.execute(parametersMap) { success, error ->
            success shouldBe null
            error shouldBe mockException
        }

        verify {
            Emarsys.predict.recommendProducts(eq(mockLogic), any())
        }
    }
}