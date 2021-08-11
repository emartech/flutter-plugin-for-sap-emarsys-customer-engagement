package com.emarsys.emarsys_sdk.command.mobileengage.contact

import com.emarsys.Emarsys
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import io.mockk.*
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

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = SetContactCommand()
        parameters = mapOf(
                "contactFieldValue" to CONTACT_FIELD_VALUE,
                "contactFieldId" to CONTACT_FIELD_ID
        )
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

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenContactFieldValueIsNotPresentInParametersMap() {
        every { Emarsys.setContact(any(), any(), any()) } just Runs

        parameters = mapOf(
            "contactFieldId" to CONTACT_FIELD_ID
        )

        command.execute(parameters) { _, _ -> }

        verify(exactly = 0) { Emarsys.setContact(any(), any(), any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenContactFieldIdIsNotPresentInParametersMap() {
        every { Emarsys.setContact(any(), any(), any()) } just Runs

        parameters = mapOf(
            "contactFieldValue" to CONTACT_FIELD_VALUE,
        )

        command.execute(parameters) { _, _ -> }

        verify(exactly = 0) { Emarsys.setContact(any(), any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.setContact(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_withError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.setContact(any(), any(), any()) } answers {
            thirdArg<CompletionListener>().onCompleted(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}