package com.emarsys.emarsys_sdk.command.mobileengage

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test


class TrackCustomEventCommandTest {

    private companion object {
        private const val EVENT_NAME = "eventName"
        private val EVENT_ATTRIBUTES = mapOf(
            "key1" to "value1",
            "key2" to "value2"
        )
    }

    private lateinit var command: TrackCustomEventCommand
    private lateinit var parameters: Map<String, Any>
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        mockResultCallback = mockk(relaxed = true)
        command = TrackCustomEventCommand()

        parameters = mapOf(
            "eventName" to EVENT_NAME,
            "eventAttributes" to EVENT_ATTRIBUTES
        )
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.trackCustomEvent(any(), any(), any()) } just Runs

        command.execute(mapOf("eventName" to EVENT_NAME)) { _, _ ->
        }

        verify { Emarsys.trackCustomEvent(any(), null, any()) }
    }

    @Test
    fun testExecute_shouldThrowException_whenEventNameIsMissing() {
        every { Emarsys.trackCustomEvent(any(), any(), any()) } just Runs

        command.execute(mapOf(), mockResultCallback)

        verify(exactly = 0) { Emarsys.trackCustomEvent(any(), any(), any()) }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys_withCorrectParameters() {
        every { Emarsys.trackCustomEvent(any(), any(), any()) } just Runs

        command.execute(parameters) { _, _ ->
        }

        verify { Emarsys.trackCustomEvent(EVENT_NAME, EVENT_ATTRIBUTES, any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        every { Emarsys.trackCustomEvent(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_withError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.trackCustomEvent(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}