package com.emarsys.emarsys_sdk.command.mobileengage.inbox

import com.emarsys.Emarsys
import com.emarsys.core.api.result.Try
import com.emarsys.emarsys_sdk.mapper.InboxResultMapper
import com.emarsys.mobileengage.api.inbox.InboxResult
import com.emarsys.mobileengage.api.inbox.Message
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test
import java.lang.Exception
import java.util.concurrent.CountDownLatch

class FetchMessagesCommandTest {
    private lateinit var command: FetchMessagesCommand
    private lateinit var mockInboxResultMapper: InboxResultMapper

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)

        mockInboxResultMapper = mockk()
        command = FetchMessagesCommand(mockInboxResultMapper)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnMessagesFromEmarsysInSuccess() {
        val latch = CountDownLatch(1)
        val message1 : Message = mockk()
        val message2 : Message = mockk()
        val inboxResult = InboxResult(listOf(message1, message2))
        val expectedResult : List<Map<String, Any>> = mockk()

        every { Emarsys.messageInbox.fetchMessages(any<((Try<InboxResult>) -> Unit)>()) } answers {
            firstArg<((Try<InboxResult>) -> Unit)>().invoke(Try.success(inboxResult))
        }
        every { mockInboxResultMapper.map(inboxResult) } returns expectedResult

        var result : List<Map<String, Any>>? = null
        command.execute(null) { success, _ ->
            result = success as? List<Map<String, Any>>?
            latch.countDown()
        }

        latch.await()
        verify { Emarsys.messageInbox.fetchMessages(any<((Try<InboxResult>) -> Unit)>()) }
        verify { mockInboxResultMapper.map(inboxResult) }
        result shouldBe expectedResult
    }

    @Test
    fun testExecute_shouldNotReturnMessagesFromEmarsysInFailure() {
        val latch = CountDownLatch(1)
        val mockException : Exception = mockk()

        every { Emarsys.messageInbox.fetchMessages(any<((Try<InboxResult>) -> Unit)>()) } answers {
            firstArg<((Try<InboxResult>) -> Unit)>().invoke(Try.failure(mockException))
        }
        var returnedError : Throwable? = null
        command.execute(null) { _, error ->
            returnedError = error
            latch.countDown()
        }

        latch.await()
        verify { Emarsys.messageInbox.fetchMessages(any<((Try<InboxResult>) -> Unit)>()) }
        returnedError shouldBe mockException
    }
}