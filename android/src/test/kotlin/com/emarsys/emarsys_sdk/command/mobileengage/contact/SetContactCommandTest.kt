package com.emarsys.emarsys_sdk.command.mobileengage.contact

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetContactCommandTest {
    companion object {
        private const val CONTACT_FIELD_VALUE = "testContactId"
        private const val CONTACT_FIELD_ID = 58008
    }

    private lateinit var command: SetContactCommand
    private lateinit var parameters: Map<String, Any>
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = SetContactCommand()
        parameters = mapOf(
                "contactFieldValue" to CONTACT_FIELD_VALUE,
                "contactFieldId" to CONTACT_FIELD_ID
        )
        mockResultCallback = mockk(relaxed = true)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.setContact(any(), any(), any()) } just Runs


        command.execute(parameters) { _, _ ->
        }

        verify { Emarsys.setContact(CONTACT_FIELD_ID, CONTACT_FIELD_VALUE, any()) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithError_whenContactFieldValueIsNotPresentInParametersMap() {
        every { Emarsys.setContact(any(), any(), any()) } just Runs

        parameters = mapOf(
            "contactFieldId" to CONTACT_FIELD_ID
        )

        command.execute(parameters, mockResultCallback)

        verify(exactly = 0) { Emarsys.setContact(any(), any(), any()) }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldThrowException_whenContactFieldIdIsNotPresentInParametersMap() {
        every { Emarsys.setContact(any(), any(), any()) } just Runs

        parameters = mapOf(
            "contactFieldValue" to CONTACT_FIELD_VALUE,
        )

        command.execute(parameters, mockResultCallback)

        verify(exactly = 0) { Emarsys.setContact(any(), any(), any()) }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        every { Emarsys.setContact(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_withError() {
        val testError = Throwable()

        every { Emarsys.setContact(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}