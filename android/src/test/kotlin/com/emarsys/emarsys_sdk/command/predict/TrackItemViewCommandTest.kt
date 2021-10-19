package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class TrackItemViewCommandTest {

    private lateinit var command: TrackItemViewCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = TrackItemViewCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.predict.trackItemView(any()) } just Runs

        command.execute(mapOf("itemId" to "testItemId")) { _, _ ->
        }

        verify { Emarsys.predict.trackItemView("testItemId") }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenItemIdIsMissing() {
        every { Emarsys.predict.trackItemView(any()) } just Runs

        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackItemView(any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackItemView(any()) } just Runs

        command.execute(mapOf("itemId" to "testItemId"), mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }
}