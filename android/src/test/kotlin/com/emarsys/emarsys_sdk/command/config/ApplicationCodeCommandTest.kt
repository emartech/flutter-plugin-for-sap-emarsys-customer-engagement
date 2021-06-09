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

class ApplicationCodeCommandTest {
    private lateinit var command: ApplicationCodeCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = ApplicationCodeCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnAppCodeFromEmarsysInSuccess() {
        every { Emarsys.config.applicationCode } returns "testApplicationCode"

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.applicationCode }
        result shouldBe "testApplicationCode"
    }

    @Test
    fun testExecute_shouldReturnNullWhenAppCodeIsNull() {
        every { Emarsys.config.applicationCode } returns null

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.applicationCode }
        result shouldBe null
    }
}