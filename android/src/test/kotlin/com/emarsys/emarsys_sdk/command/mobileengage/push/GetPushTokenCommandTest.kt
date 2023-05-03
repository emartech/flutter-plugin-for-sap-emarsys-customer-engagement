package com.emarsys.emarsys_sdk.command.mobileengage.push

import com.emarsys.Emarsys
import com.emarsys.push.Push
import io.kotlintest.shouldBe
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.jupiter.api.Assertions.*

internal class GetPushTokenCommandTest {
    private companion object {
        const val PUSH_TOKEN = "testPushToken"
    }

    private lateinit var command: GetPushTokenCommand
    private lateinit var mockPush: Push

    @Before
    fun setUp() {
        mockPush = mockk(relaxed = true)
        mockkStatic(Emarsys::class)
        every { Emarsys.push } returns mockPush
        every { mockPush.pushToken } returns PUSH_TOKEN
        command = GetPushTokenCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        command.execute(null) { result, _ ->
            result shouldBe PUSH_TOKEN
        }
    }

}