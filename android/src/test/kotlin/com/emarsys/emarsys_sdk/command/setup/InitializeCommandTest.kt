package com.emarsys.emarsys_sdk.command.setup

import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.clearAllMocks
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class InitializeCommandTest {

    private lateinit var command: InitializeCommand
    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var mockBackgroundHandler: Handler
    private lateinit var mockEdit: SharedPreferences.Editor

    @Before
    fun setUp() {
        mockSharedPreferences = mockk()
        mockBackgroundHandler = mockk(relaxed = true)
        every { mockBackgroundHandler.post(any()) } answers {
            (it.invocation.args[0] as Runnable).run()
            true
        }
        command = InitializeCommand(mockSharedPreferences, mockBackgroundHandler)
        mockEdit = mockk(relaxed = true)
        every { mockSharedPreferences.edit() } returns mockEdit
    }

    @After
    fun tearDown() {
        clearAllMocks()
    }

    @Test
    fun testExecute_withCallBackHandle() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        command.execute(mapOf("callbackHandle" to 123L), mockResultCallback)

        verify {
            mockEdit.putLong(
                "callback_handle",
                123
            )
        }
        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_withoutCallbackHandle() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        command.execute(mapOf(), mockResultCallback)

        verify(exactly = 0) { mockEdit.putLong(any(), any()) }
        verify { mockResultCallback.invoke(null, null) }
    }
}