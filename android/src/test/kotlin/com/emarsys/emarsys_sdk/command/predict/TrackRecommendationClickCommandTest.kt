package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.mapper.MapToProductMapper
import com.emarsys.predict.api.model.Product
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class TrackRecommendationClickCommandTest {

    private lateinit var command: EmarsysCommand
    private lateinit var mockMapper: MapToProductMapper
    private lateinit var mockProduct: Product

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        mockProduct = mockk(relaxed = true)
        mockMapper = mockk(relaxed = true)
        command = TrackRecommendationClickCommand(mockMapper)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        val input = mapOf(
            "product" to mapOf(
                "productId" to "test_productId"
            )
        )

        every { Emarsys.predict.trackRecommendationClick(any()) } just Runs
        every { mockMapper.map(any()) } returns mockProduct
        command.execute(input) { _, _ ->
        }

        verify { Emarsys.predict.trackRecommendationClick(mockProduct) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenProductIsMissing() {
        every { Emarsys.predict.trackRecommendationClick(any()) } just Runs

        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackRecommendationClick(any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val input = mapOf(
            "product" to mapOf(
                "productId" to "test_productId"
            )
        )
        val mockProduct: Product = mockk()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackRecommendationClick(any()) } just Runs
        every { mockMapper.map(input) } returns mockProduct

        command.execute(
            input, mockResultCallback
        )

        verify { mockResultCallback.invoke(null, null) }
    }
}