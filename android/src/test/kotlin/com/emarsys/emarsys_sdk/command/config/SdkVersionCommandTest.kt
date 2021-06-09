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

class SdkVersionCommandTest {
    private lateinit var command: SdkVersionCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = SdkVersionCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnSdkVersionFromEmarsysInSuccess() {
        every { Emarsys.config.sdkVersion } returns "testSdkVersion"

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.sdkVersion }
        result shouldBe "testSdkVersion"
    }
}