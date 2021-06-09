package com.emarsys.emarsys_sdk.command.config

import com.emarsys.Emarsys
import io.kotlintest.shouldBe
import io.mockk.every
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class MerchantIdCommandTest {
    private lateinit var command: MerchantIdCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = MerchantIdCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnMerchantIdFromEmarsysInSuccess() {
        every { Emarsys.config.merchantId } returns "testMerchantId"

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.merchantId }
        result shouldBe "testMerchantId"
    }

    @Test
    fun testExecute_shouldReturnNullWhenMerchantIdIsNull() {
        every { Emarsys.config.merchantId } returns null

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.merchantId }
        result shouldBe null
    }
}