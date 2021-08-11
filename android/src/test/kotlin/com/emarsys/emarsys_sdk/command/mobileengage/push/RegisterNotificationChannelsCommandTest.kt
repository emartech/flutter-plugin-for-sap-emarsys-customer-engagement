package com.emarsys.emarsys_sdk.command.mobileengage.push

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import com.emarsys.core.util.AndroidVersionUtils
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class RegisterNotificationChannelsCommandTest {
    private lateinit var command: RegisterNotificationChannelsCommand
    private lateinit var mockApplication: Application
    private lateinit var mockNotificationManager: NotificationManager
    private lateinit var mockNotificationChannelFactory: NotificationChannelFactory
    private lateinit var mockNotificationChannel: NotificationChannel
    private lateinit var mockNotificationChannel2: NotificationChannel

    @Before
    fun setUp() {
        mockkStatic(AndroidVersionUtils::class)
        every { AndroidVersionUtils.isOreoOrAbove() } returns true
        mockApplication = mockk()
        mockNotificationChannelFactory = mockk()
        mockNotificationManager = mockk(relaxed = true)
        mockNotificationChannel = mockk(relaxed = true)
        mockNotificationChannel2 = mockk(relaxed = true)
        every { mockApplication.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager } returns mockNotificationManager
        command = RegisterNotificationChannelsCommand(mockApplication, mockNotificationChannelFactory)
    }

    @After
    fun tearDown() {
        unmockkAll()
    }

    @Test
    fun testExecute_ShouldRegisterChannelsFromParametersMap_toNotificationManager() {
        val parametersMap = mapOf(
            "notificationChannels" to listOf(
                mapOf(
                    "id" to "testId",
                    "name" to "testName",
                    "description" to "testDescription",
                    "importance" to 1
                ),
                mapOf(
                    "id" to "testId2",
                    "name" to "testName2",
                    "description" to "testDescription2",
                    "importance" to 1
                )
            )
        )

        every {
            mockNotificationChannelFactory.createChannel(
                "testId",
                "testName",
                1,
                "testDescription"
            )
        } returns mockNotificationChannel

        every {
            mockNotificationChannelFactory.createChannel(
                "testId2",
                "testName2",
                1,
                "testDescription2"
            )
        } returns mockNotificationChannel2

        command.execute(parametersMap) { _, _ -> }

        verify { mockNotificationManager.createNotificationChannel(mockNotificationChannel) }
        verify { mockNotificationManager.createNotificationChannel(mockNotificationChannel2) }
    }

    @Test(expected = NullPointerException::class)
    fun testExecute_shouldThrowExceptionOnInvalidArguments() {
        val parametersMap = mapOf(
            "notificationChannels" to listOf(
                mapOf(
                    "id" to "testId",
                    "description" to "testDescription",
                    "importance" to 1
                )
            )
        )

        every {
            mockNotificationChannelFactory.createChannel(
                "testId",
                "testName",
                1,
                "testDescription"
            )
        } returns mockNotificationChannel

        command.execute(parametersMap) { _, _ -> }
    }

    @Test
    fun testExecute_shouldDoNothingIfBelowOreo() {
        every { AndroidVersionUtils.isOreoOrAbove() } returns false
        verify { mockNotificationManager wasNot called }
    }
}