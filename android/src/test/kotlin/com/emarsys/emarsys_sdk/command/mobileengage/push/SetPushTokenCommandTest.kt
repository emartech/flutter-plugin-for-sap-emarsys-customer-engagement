package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.push.Push
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetPushTokenCommandTest {
    private lateinit var command: SetPushTokenCommand
    private lateinit var mockPush: Push

    @Before
    fun setUp() {
        mockPush = mockk(relaxed = true)
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

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenPushTokenIsNull() {
        command.execute(mapOf()) { _, _ ->
        }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenPushTokenIsEmpty() {
        command.execute(mapOf("pushToken" to "")) { _, _ ->
        }
    }
}