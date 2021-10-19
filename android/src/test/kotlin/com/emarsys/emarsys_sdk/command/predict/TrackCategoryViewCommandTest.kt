package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

internal class TrackCategoryViewCommandTest {
    private lateinit var command: EmarsysCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = TrackCategoryViewCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.predict.trackCategoryView(any()) } just Runs

        command.execute(
            mapOf(
                "categoryPath" to "testCategoryPath",
            )
        ) { _, _ ->
        }

        verify { Emarsys.predict.trackCategoryView("testCategoryPath") }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenCategoryPathIsMissing() {
        every { Emarsys.predict.trackCategoryView(any()) } just Runs

        command.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.predict.trackCategoryView(any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.predict.trackCategoryView(any()) } just Runs

        command.execute(
            mapOf(
                "categoryPath" to "testCategoryPath",
            ), mockResultCallback
        )

        verify { mockResultCallback.invoke(null, null) }
    }
}