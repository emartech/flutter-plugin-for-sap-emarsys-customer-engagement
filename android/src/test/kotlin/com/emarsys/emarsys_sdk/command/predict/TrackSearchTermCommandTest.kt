package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

internal class TrackSearchTermCommandTest {
    private lateinit var command: EmarsysCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = TrackSearchTermCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.predict.trackSearchTerm(any()) } just Runs

        command.execute(
            mapOf(
                "searchTerm" to "testSearchTerm",
            )
        ) { _, _ ->
        }

        verify { Emarsys.predict.trackSearchTerm("testSearchTerm") }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenSearchTermIsMissing() {
        every { Emarsys.predict.trackSearchTerm(any()) } just Runs

        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackSearchTerm(any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackSearchTerm(any()) } just Runs

        command.execute(
            mapOf(
                "searchTerm" to "testSearchTerm",
            ), mockResultCallback
        )

        verify { mockResultCallback.invoke(null, null) }
    }
}