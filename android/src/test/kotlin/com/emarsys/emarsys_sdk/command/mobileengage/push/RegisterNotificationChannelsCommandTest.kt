package com.emarsys.emarsys_sdk.command.mobileengage.push

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import com.emarsys.core.util.AndroidVersionUtils
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory
import io.kotlintest.shouldBe
import io.kotlintest.shouldNotBe
import io.mockk.called
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkAll
import io.mockk.verify
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
    private lateinit var mockResultCallback: ResultCallback

    @Before
    fun setUp() {
        mockkObject(AndroidVersionUtils)
        every { AndroidVersionUtils.isOreoOrAbove } returns true
        mockApplication = mockk()
        mockNotificationChannelFactory = mockk()
        mockNotificationManager = mockk(relaxed = true)
        mockNotificationChannel = mockk(relaxed = true)
        mockNotificationChannel2 = mockk(relaxed = true)
        mockResultCallback = mockk(relaxed = true)
        every { mockApplication.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager } returns mockNotificationManager
        command =
            RegisterNotificationChannelsCommand(mockApplication, mockNotificationChannelFactory)
    }

    @After
    fun tearDown() {
        unmockkAll()
    }

    @Test
    fun testExecute_ShouldRegisterChannelsFromParametersMap_toNotificationManager_andCallResultCallback() {
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

        command.execute(parametersMap, mockResultCallback)

        verify { mockNotificationManager.createNotificationChannel(mockNotificationChannel) }
        verify { mockNotificationManager.createNotificationChannel(mockNotificationChannel2) }
        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithError_whenNotificationChannelMapIsIncomplete() {
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

        var returnedError: Throwable? = null

        command.execute(parametersMap) { _, error ->
            returnedError = error
        }

        returnedError shouldNotBe null
        (returnedError is IllegalArgumentException) shouldBe true
    }

    @Test
    fun testExecute_shouldDoNothingIfBelowOreo_andCallResultCallback() {
        val parametersMap = mapOf(
            "notificationChannels" to listOf(
                mapOf(
                    "id" to "testId",
                    "description" to "testDescription",
                    "importance" to 1
                )
            )
        )
        every { AndroidVersionUtils.isOreoOrAbove } returns false

        command.execute(parametersMap, mockResultCallback)

        verify { mockNotificationManager wasNot called }
        verify { mockResultCallback.invoke(null, null) }
    }
}