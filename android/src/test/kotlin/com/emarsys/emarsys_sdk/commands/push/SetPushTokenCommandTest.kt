package com.emarsys.emarsys_sdk.commands.push

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.commands.ResultCallback
import com.emarsys.push.PushApi
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetPushTokenCommandTest {
    companion object {
        private const val PUSH_TOKEN = "testPushToken"
        private val parametersMap = mapOf(
                "pushToken" to PUSH_TOKEN
        )
    }

    private lateinit var command: SetPushTokenCommand
    private lateinit var mockPushApi: PushApi
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        command = SetPushTokenCommand()

        mockPushApi = mockk(relaxed = true)
        every { mockPushApi.setPushToken(any(), any()) } just Runs

        mockResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every { Emarsys.push } returns mockPushApi
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldInvokeMethodOnEmarsys() {
        command.execute(parametersMap) { _, _ ->
        }

        verify { mockPushApi.setPushToken(any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeMethodOnEmarsys_withPassedArguments() {
        command.execute(parametersMap) { _, _ ->
        }

        verify { mockPushApi.setPushToken(PUSH_TOKEN, any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenPushTokenIsNotPresent() {
        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { mockPushApi.setPushToken(any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        every { mockPushApi.setPushToken(any(), any()) } answers { _ ->
            secondArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parametersMap, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallbackWithError() {
        val testError = Throwable()

        every { mockPushApi.setPushToken(any(), any()) } answers { _ ->
            secondArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parametersMap, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}