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

class HardwareIdCommandTest {
    private lateinit var command: HardwareIdCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = HardwareIdCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnHardwareIdFromEmarsysInSuccess() {
        every { Emarsys.config.hardwareId } returns "testHardwareId"

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.hardwareId }
        result shouldBe "testHardwareId"
    }
}