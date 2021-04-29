package com.emarsys.emarsys_sdk.commands.push

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.commands.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class ClearPushTokenCommandTest {

    private lateinit var command: ClearPushTokenCommand

    @Before
    fun setUp() {
        command = ClearPushTokenCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldInvokeMethodOnEmarsys() {
        mockkStatic(Emarsys::class)
        every { Emarsys.push.clearPushToken(any()) } just Runs

        command.execute(null) { success, error ->
        }

        verify { Emarsys.push.clearPushToken(any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every {
            Emarsys.push.clearPushToken(any<CompletionListener>())
        } answers { call ->
            firstArg<CompletionListener>().onCompleted(null)
        }

        command.execute(null, mockResultCallback)

        verify { Emarsys.push.clearPushToken(any<CompletionListener>()) }
        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallbackWithErrorOnError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every {
            Emarsys.push.clearPushToken(any<CompletionListener>())
        } answers { call ->
            firstArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(null, mockResultCallback)

        verify { Emarsys.push.clearPushToken(any<CompletionListener>()) }
        verify { mockResultCallback.invoke(null, testError) }
    }
}