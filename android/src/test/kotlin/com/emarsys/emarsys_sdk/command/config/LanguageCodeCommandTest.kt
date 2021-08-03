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

class LanguageCodeCommandTest {
    private lateinit var command: LanguageCodeCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = LanguageCodeCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnLanguageCodeFromEmarsysInSuccess() {
        every { Emarsys.config.languageCode } returns "testLanguageCode"

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.languageCode }
        result shouldBe "testLanguageCode"
    }
}