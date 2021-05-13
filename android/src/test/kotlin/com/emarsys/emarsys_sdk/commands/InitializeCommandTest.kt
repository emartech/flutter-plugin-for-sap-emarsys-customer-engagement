package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.FlutterBackgroundExecutor
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class InitializeCommandTest {

    private lateinit var command: InitializeCommand

    @Before
    fun setUp() {
        command = InitializeCommand()

        mockkObject(FlutterBackgroundExecutor)
        every { FlutterBackgroundExecutor.setCallbackDispatcher(any()) } just Runs
    }

    @After
    fun tearDown() {
        unmockkObject(FlutterBackgroundExecutor)
    }

    @Test
    fun testExecute_withCallBackHandle() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        command.execute(mapOf("callbackHandle" to 123L), mockResultCallback)

        verify { FlutterBackgroundExecutor.setCallbackDispatcher(123L) }
        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_withoutCallbackHandle() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        command.execute(mapOf(), mockResultCallback)

        verify(exactly = 0) { FlutterBackgroundExecutor.setCallbackDispatcher(any()) }
        verify { mockResultCallback.invoke(null, null) }
    }
}