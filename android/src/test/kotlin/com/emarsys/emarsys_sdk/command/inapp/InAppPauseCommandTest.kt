package com.emarsys.emarsys_sdk.command.inapp

import com.emarsys.Emarsys
import com.emarsys.inapp.InAppApi
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class InAppPauseCommandTest {
    private lateinit var command: InAppPauseCommand
    private lateinit var mockInAppApi: InAppApi

    @Before
    fun setUp() {
        command = InAppPauseCommand()
        mockInAppApi = mockk()

        mockkStatic(Emarsys::class)
        every {
            Emarsys.inApp
        } returns mockInAppApi
    }

    @After
    fun tearDown() {
        unmockkAll()
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { mockInAppApi.pause() } just Runs
        command.execute(null) { _, _ ->
        }

        verify { mockInAppApi.pause() }
    }

    @Test
    fun testExecute_shouldCallResultCallback() {
        every { mockInAppApi.pause() } just Runs

        var resultCallbackCalled = false
        command.execute(null) { _, _ ->
            resultCallbackCalled = true
        }

        verify { mockInAppApi.pause() }
        resultCallbackCalled shouldBe true
    }
}