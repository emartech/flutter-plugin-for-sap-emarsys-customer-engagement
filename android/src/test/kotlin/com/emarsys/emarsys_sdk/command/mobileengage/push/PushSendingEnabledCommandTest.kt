package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import com.emarsys.push.PushApi
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkAll
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class PushSendingEnabledCommandTest {
    private companion object {
        const val PUSH_TOKEN = "push_token"
    }

    private lateinit var command: PushSendingEnabledCommand
    private lateinit var parameters: Map<String, Any>
    private lateinit var mockPushApi: PushApi
    private lateinit var mockResultCallback: ResultCallback
    private lateinit var mockPushTokenStorage: PushTokenStorage

    @Before
    fun setUp() {
        mockPushApi = mockk(relaxed = true)
        every { mockPushApi.setPushToken(any(), any()) } just Runs

        mockResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every { Emarsys.push } returns mockPushApi
        mockPushTokenStorage = mockk()
        every { mockPushTokenStorage.pushToken } returns PUSH_TOKEN
        command = PushSendingEnabledCommand(mockPushTokenStorage)
    }

    @After
    fun tearDown() {
        unmockkAll()
        unmockkStatic(Emarsys::class)
    }


    @Test
    fun testExecute_shouldInvokeResultCallbackWithError_whenPushSendingEnabledIsMissing() {
        every { mockPushTokenStorage.pushToken } returns null
        parameters = mapOf(
        )
        var returnedError: Throwable? = null

        command.execute(parameters) { _, error ->
            returnedError = error
        }

        verify(exactly = 0) { mockPushApi.setPushToken(any(), any()) }
        verify(exactly = 0) { mockPushApi.clearPushToken() }
        returnedError shouldNotBe null
        (returnedError is IllegalArgumentException) shouldBe true
        returnedError?.message shouldBe "pushSendingEnabled must not be null"
    }

    @Test
    fun testExecute_shouldCallSetPushTokenIfEnabled() {
        parameters = mapOf(
            "pushSendingEnabled" to true
        )

        command.execute(parameters) { _, _ ->
        }

        verify { mockPushApi.setPushToken(PUSH_TOKEN, any()) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithError_whenPushTokenIsMissing() {
        every { mockPushTokenStorage.pushToken } returns null
        parameters = mapOf(
            "pushSendingEnabled" to true
        )
        var returnedError: Throwable? = null

        command.execute(parameters) { _, error ->
            returnedError = error
        }

        verify(exactly = 0) { mockPushApi.setPushToken(any(), any()) }
        returnedError shouldNotBe null
        (returnedError is IllegalArgumentException) shouldBe true
        returnedError?.message shouldBe "PushToken must not be null"
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_whenEnable() {
        parameters = mapOf(
            "pushSendingEnabled" to true
        )
        every { mockPushApi.setPushToken(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallbackWithError_whenEnable() {
        val testError = Throwable()
        parameters = mapOf(
            "pushSendingEnabled" to true
        )

        every { mockPushApi.setPushToken(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }

    @Test
    fun testExecute_shouldCallClearPushTokenIfDisabled() {
        parameters = mapOf(
            "pushSendingEnabled" to false
        )

        command.execute(parameters) { _, _ ->
        }

        verify { mockPushApi.clearPushToken(any()) }
    }
}