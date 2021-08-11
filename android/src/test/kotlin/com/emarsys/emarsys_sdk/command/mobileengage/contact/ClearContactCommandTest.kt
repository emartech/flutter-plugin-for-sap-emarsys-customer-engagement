package com.emarsys.emarsys_sdk.command.mobileengage.contact

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class ClearContactCommandTest {
    private lateinit var command: ClearContactCommand

    @Before
    fun setUp() {
        command = ClearContactCommand()
    }

    @After
    fun tearDown() {
        unmockkAll()
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallClearContactOnEmarsys() {
        mockkStatic(Emarsys::class)
        every {
            Emarsys.clearContact(any<CompletionListener>())
        } just Runs

        command.execute(null) { _, _ ->
        }

        verify { Emarsys.clearContact(any<CompletionListener>()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallbackWithErrorOnError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every {
            Emarsys.clearContact(any<CompletionListener>())
        } answers {
            firstArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(null, mockResultCallback)

        verify { Emarsys.clearContact(any<CompletionListener>()) }
        verify { mockResultCallback.invoke(null, testError) }
    }
}