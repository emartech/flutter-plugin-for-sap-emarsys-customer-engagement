package com.emarsys.emarsys_sdk.command.inapp

import com.emarsys.Emarsys
import com.emarsys.inapp.InAppApi
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class InAppIsPausedCommandTest {
    private lateinit var command: InAppIsPausedCommand
    private lateinit var mockInAppApi: InAppApi

    @Before
    fun setUp() {
        command = InAppIsPausedCommand()
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
        command.execute(null) { _, _ ->
        }

        verify { mockInAppApi.isPaused }
    }

    @Test
    fun testExecute_shouldReturnFalseIfNotPaused() {
        every {
            mockInAppApi.isPaused
        } returns false

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { mockInAppApi.isPaused }
        result shouldBe false
    }

    @Test
    fun testExecute_shouldReturnTrueIfPaused() {
        every {
            mockInAppApi.isPaused
        } returns true

        var result : Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { mockInAppApi.isPaused }
        result shouldBe true
    }
}