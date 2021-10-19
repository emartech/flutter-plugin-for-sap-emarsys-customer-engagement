package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

internal class TrackTagCommandTest {

    private lateinit var command: EmarsysCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = TrackTagCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.predict.trackTag(any(), any()) } just Runs

        command.execute(
            mapOf(
                "eventName" to "testEventName",
                "attributes" to mapOf("key" to "value")
            )
        ) { _, _ ->
        }

        verify { Emarsys.predict.trackTag("testEventName", mapOf("key" to "value")) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenEventNameIsMissing() {
        every { Emarsys.predict.trackTag(any(), any()) } just Runs

        command.execute(mapOf("attributes" to mapOf<String, String>())) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackTag(any(), any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenAttributesIsMissing() {
        every { Emarsys.predict.trackTag(any(), any()) } just Runs

        command.execute(mapOf("eventName" to "testEventName")) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackTag(any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackTag(any(), any()) } just Runs

        command.execute(
            mapOf(
                "eventName" to "testEventName",
                "attributes" to mapOf("key" to "value")
            ), mockResultCallback
        )

        verify { mockResultCallback.invoke(null, null) }
    }
}