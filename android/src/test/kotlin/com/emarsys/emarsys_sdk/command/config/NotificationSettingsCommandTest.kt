package com.emarsys.emarsys_sdk.command.config

import com.emarsys.Emarsys
import com.emarsys.core.api.notification.ChannelSettings
import com.emarsys.core.api.notification.NotificationSettings
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class NotificationSettingsCommandTest {
    private lateinit var command: NotificationSettingsCommand
    private lateinit var mockNotificationSettings: NotificationSettings

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        command = NotificationSettingsCommand()
        mockNotificationSettings = mockk(relaxed = true)
        every { mockNotificationSettings.areNotificationsEnabled } returns true
        every { mockNotificationSettings.importance } returns 1
        every { mockNotificationSettings.channelSettings } returns listOf(
            ChannelSettings(
                "testChannelId1",
                1000,
                isCanBypassDnd = false,
                isCanShowBadge = false,
                isShouldVibrate = false,
                isShouldShowLights = false
            ),
            ChannelSettings(
                "testChannelId2",
                2000,
                isCanBypassDnd = true,
                isCanShowBadge = true,
                isShouldVibrate = true,
                isShouldShowLights = true
            )
        )
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldReturnNotificationSettingsFromEmarsysInSuccess() {
        val notificationsSettingsMap = mapOf<String, Any>(
            "android" to mapOf(
                "areNotificationsEnabled" to true,
                "importance" to 1,
                "channelSettings" to listOf(
                    mapOf(
                        "channelId" to "testChannelId1",
                        "importance" to 1000,
                        "isCanBypassDnd" to false,
                        "isCanShowBadge" to false,
                        "isShouldVibrate" to false,
                        "isShouldShowLights" to false
                    ),
                    mapOf(
                        "channelId" to "testChannelId2",
                        "importance" to 2000,
                        "isCanBypassDnd" to true,
                        "isCanShowBadge" to true,
                        "isShouldVibrate" to true,
                        "isShouldShowLights" to true
                    )
                )
            )
        )
        every { Emarsys.config.notificationSettings } returns mockNotificationSettings

        var result: Any? = null
        command.execute(null) { success, _ ->
            result = success
        }

        verify { Emarsys.config.notificationSettings }
        result shouldBe notificationsSettingsMap
    }
}