package com.emarsys.emarsys_sdk.command.mobileengage.inbox

import com.emarsys.Emarsys
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

class RemoveTagCommandTest {
    companion object {
        private const val MESSAGE_ID = "testMessageId"
        private const val TAG = "testTag"
    }

    private lateinit var command: RemoveTagCommand
    private lateinit var parameters: Map<String, Any>
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = RemoveTagCommand()
        parameters = mapOf(
            "messageId" to MESSAGE_ID,
            "tag" to TAG
        )
        mockResultCallback = mockk(relaxed = true)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { Emarsys.messageInbox.removeTag(any(), any(), any<((Throwable?) -> Unit)>()) } just Runs


        command.execute(parameters) { _, _ ->
        }

        verify { Emarsys.messageInbox.removeTag(TAG, MESSAGE_ID, any<((Throwable?) -> Unit)>()) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithException_whenMessageIdIsNotPresentInParametersMap() {
        every { Emarsys.messageInbox.removeTag(any(), any(), any<((Throwable?) -> Unit)>()) } just Runs

        parameters = mapOf(
            "messageId" to MESSAGE_ID
        )

        command.execute(parameters, mockResultCallback)

        verify(exactly = 0) {
            Emarsys.messageInbox.removeTag(
                any(),
                any(),
                any<((Throwable?) -> Unit)>()
            )
        }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithException_whenTagIsNotPresentInParametersMap() {
        every { Emarsys.messageInbox.removeTag(any(), any(), any<((Throwable?) -> Unit)>()) } just Runs

        parameters = mapOf(
            "tag" to TAG,
        )

        command.execute(parameters, mockResultCallback)

        verify(exactly = 0) {
            Emarsys.messageInbox.removeTag(
                any(),
                any(),
                any<((Throwable?) -> Unit)>()
            )
        }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.messageInbox.removeTag(any(), any(), any<((Throwable?) -> Unit)>()) } answers {
            thirdArg<((Throwable?) -> Unit)>().invoke(null)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldInvokeResultCallback_withError() {
        val testError = Throwable()
        val mockResultCallback: ResultCallback = mockk(relaxed = true)

        every { Emarsys.messageInbox.removeTag(any(), any(), any<((Throwable?) -> Unit)>()) } answers {
            thirdArg<((Throwable?) -> Unit)>().invoke(testError)
        }

        command.execute(parameters, mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
    }
}