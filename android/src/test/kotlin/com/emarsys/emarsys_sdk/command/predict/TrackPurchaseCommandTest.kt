package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.predict.api.model.CartItem
import com.emarsys.predict.api.model.PredictCartItem
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.jupiter.api.Assertions.*

internal class TrackPurchaseCommandTest {

    private lateinit var command: EmarsysCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = TrackPurchaseCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.predict.trackPurchase(any(), any()) } just Runs

        command.execute(
            mapOf(
                "orderId" to "testOrderId",
                "items" to listOf(
                    mapOf("itemId" to "itemId1", "price" to 0.0, "quantity" to 1.0),
                    mapOf("itemId" to "itemId2", "price" to 1.0, "quantity" to 2.0)
                )
            )
        ) { _, _ ->
        }

        verify {
            Emarsys.predict.trackPurchase(
                "testOrderId",
                listOf(createCartItem("itemId1", 0.0, 1.0), createCartItem("itemId2", 1.0, 2.0))
            )
        }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenOrderIdIsMissing() {
        every { Emarsys.predict.trackPurchase(any(), any()) } just Runs

        command.execute(mapOf("items" to mapOf<String, String>())) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackPurchase(any(), any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenItemsIsMissing() {
        every { Emarsys.predict.trackPurchase(any(), any()) } just Runs

        command.execute(mapOf("orderId" to "testEventName")) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackPurchase(any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackPurchase(any(), any()) } just Runs

        command.execute(
            mapOf(
                "orderId" to "testOrderId",
                "items" to listOf(
                    mapOf("itemId" to "itemId1", "price" to 0.0, "quantity" to 1.0),
                    mapOf("itemId" to "itemId2", "price" to 1.0, "quantity" to 2.0)
                )
            ), mockResultCallback
        )

        verify { mockResultCallback.invoke(null, null) }
    }

    private fun createCartItem(itemId: String, price: Double, quantity: Double): CartItem {
        return PredictCartItem(itemId, price, quantity)
    }
}