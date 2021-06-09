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

class ContactFieldIdCommandTest {
    private lateinit var command: ContactFieldIdCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = ContactFieldIdCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnContactFieldIdFromEmarsysInSuccess() {
        every { Emarsys.config.contactFieldId } returns 2575

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.contactFieldId }
        result shouldBe 2575
    }
}