package com.emarsys.emarsys_sdk

import android.os.Handler
import com.emarsys.Emarsys
import com.emarsys.core.di.DependencyInjection
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.di.tearDownDependencyContainer
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import com.emarsys.service.EmarsysMessagingServiceUtils
import com.google.firebase.messaging.RemoteMessage
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class EmarsysMessagingServiceTest {
    private lateinit var emarsysMessagingService: EmarsysMessagingService
    private lateinit var mockFlutterBackgroundExecutor: FlutterBackgroundExecutor
    private lateinit var mockMainHandler: Handler
    private lateinit var mockMainHandlerProvider: MainHandlerProvider

    @Before
    fun setUp() {
        mockFlutterBackgroundExecutor = mockk(relaxed = true)
        mockMainHandlerProvider = mockk(relaxed = true)
        mockMainHandler = mockk(relaxed = true)

        mockkStatic(DependencyInjection::class)
        every { DependencyInjection.isSetup() } returns false

        mockkStatic(EmarsysMessagingServiceUtils::class)
        every { EmarsysMessagingServiceUtils.handleMessage(any(), any()) } returns false

        setupDependencyContainer(
            FakeDependencyContainer(
                flutterBackgroundExecutor = mockFlutterBackgroundExecutor,
                mainHandlerProvider = mockMainHandlerProvider
            )
        )

        emarsysMessagingService = spyk()
        every { emarsysMessagingService.application } returns mockk()
        every { mockMainHandlerProvider.provide() } returns mockMainHandler
        every { mockMainHandler.post(any()) } answers {
            firstArg<Runnable>().run()
            true
        }
    }

    @After
    fun tearDown() {
        tearDownDependencyContainer()

        clearMessageQueue()
        clearAllMocks()
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testOnMessageReceived_flutterBackgroundExecutor_shouldBeCalled_onMainThread() {
        emarsysMessagingService.onMessageReceived(mockk())

        verify { mockFlutterBackgroundExecutor.startBackgroundIsolate() }
    }

    @Test
    fun testOnMessageReceived_flutterBackgroundExecutor_shouldNotBeCalled_whenSDK_alreadyInitialized() {
        every { DependencyInjection.isSetup() } returns true

        emarsysMessagingService.onMessageReceived(mockk())

        verify(exactly = 0) { mockFlutterBackgroundExecutor.startBackgroundIsolate() }
    }

    @Test
    fun testOnMessageReceived_emarsysMessagingServiceUtils_handleMessage_shouldBeCalled() {
        every { DependencyInjection.isSetup() } returns true
        val mockMessage: RemoteMessage = mockk()

        emarsysMessagingService.onMessageReceived(mockMessage)

        verify { EmarsysMessagingServiceUtils.handleMessage(any(), mockMessage) }
    }

    @Test
    fun testOnMessageReceived_emarsysMessagingServiceUtils_handleMessage_shouldBeCalled_forEveryMessage() {
        val mockMessage1: RemoteMessage = mockk()
        val mockMessage2: RemoteMessage = mockk()

        emarsysMessagingService.onMessageReceived(mockMessage1)
        verify(exactly = 0) { EmarsysMessagingServiceUtils.handleMessage(any(), mockMessage1) }
        every { DependencyInjection.isSetup() } returns true

        emarsysMessagingService.onMessageReceived(mockMessage2)

        verifySequence {
            EmarsysMessagingServiceUtils.handleMessage(any(), mockMessage1)
            EmarsysMessagingServiceUtils.handleMessage(any(), mockMessage2)
        }
    }

    private fun clearMessageQueue() {
        every { DependencyInjection.isSetup() } returns true
        EmarsysMessagingService.showInitialMessages(mockk())
    }
}