package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.push.Push
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetPushTokenCommandTest {
    private lateinit var command: SetPushTokenCommand
    private lateinit var mockPush: Push
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        mockPush = mockk(relaxed = true)
        mockResultCallback = mockk(relaxed = true)
        mockkStatic(Emarsys::class)
        every { Emarsys.push } returns mockPush
        command = SetPushTokenCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        command.execute(mapOf("pushToken" to "testPushToken")) { _, _ ->
        }

        verify { mockPush.setPushToken("testPushToken", any()) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithException_whenPushTokenIsNull() {
        command.execute(mapOf(), mockResultCallback)

        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldThrowException_whenPushTokenIsEmpty() {
        command.execute(mapOf("pushToken" to ""), mockResultCallback)

        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }
}