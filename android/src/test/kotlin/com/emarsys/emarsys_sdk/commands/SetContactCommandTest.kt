package com.emarsys.emarsys_sdk.commands

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetContactCommandTest {
    companion object {
        private const val CONTACT_FIELD_VALUE = "testContactId"
    }

    private lateinit var command: SetContactCommand
    private lateinit var parameters: Map<String, Any>

    @Before
    fun setUp() {
        command = SetContactCommand()
        parameters = mapOf(
                "contactFieldValue" to CONTACT_FIELD_VALUE
        )
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        mockkStatic(Emarsys::class)
        every { Emarsys.setContact(any(), any<CompletionListener>()) } just Runs

        command.execute(parameters) { success, error ->
        }

        verify { Emarsys.setContact(CONTACT_FIELD_VALUE, any<CompletionListener>()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenContactIdIsNotPresentInParametersMap() {
        mockkStatic(Emarsys::class)
        every { Emarsys.setContact(any(), any<CompletionListener>()) } just Runs

        command.execute(mapOf()) { success, error -> }

        verify(exactly = 0) { Emarsys.setContact(any(), any<CompletionListener>()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every { Emarsys.setContact(any(), any<CompletionListener>()) } answers { call ->
            secondArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_withError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every { Emarsys.setContact(any(), any<CompletionListener>()) } answers { call ->
            secondArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}