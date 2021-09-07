package com.emarsys.emarsys_sdk.command

import com.emarsys.emarsys_sdk.command.config.*
import com.emarsys.emarsys_sdk.command.geofence.GeofenceDisableCommand
import com.emarsys.emarsys_sdk.command.geofence.GeofenceEnableCommand
import com.emarsys.emarsys_sdk.command.geofence.GeofenceInitialEnterTriggerEnabledCommand
import com.emarsys.emarsys_sdk.command.geofence.GeofenceIsEnabledCommand
import com.emarsys.emarsys_sdk.command.inapp.InAppIsPausedCommand
import com.emarsys.emarsys_sdk.command.inapp.InAppPauseCommand
import com.emarsys.emarsys_sdk.command.inapp.InAppResumeCommand
import com.emarsys.emarsys_sdk.command.mobileengage.TrackCustomEventCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.ClearContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.contact.SetContactCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.AddTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.FetchMessagesCommand
import com.emarsys.emarsys_sdk.command.mobileengage.inbox.RemoveTagCommand
import com.emarsys.emarsys_sdk.command.mobileengage.push.PushSendingEnabledCommand
import com.emarsys.emarsys_sdk.command.setup.InitializeCommand
import com.emarsys.emarsys_sdk.command.setup.SetupCommand
import io.kotlintest.shouldBe
import io.mockk.mockk
import org.junit.Before
import org.junit.Test

class EmarsysCommandFactoryTest {
    private lateinit var factory: EmarsysCommandFactory

    @Before
    fun setUp() {
        factory =
            EmarsysCommandFactory(mockk(), mockk(), mockk(), mockk(), mockk(), mockk(), mockk())
    }

    @Test
    fun testCreate_shouldCreateASetupCommandFromMethodCall() {
        val result = factory.create("setup")

        result shouldBe SetupCommand(mockk(), mockk(), mockk(), mockk(), false)
    }

    @Test
    fun testCreate_shouldCreateASetupFromCacheCommandFromMethodCall() {
        val result = factory.create("android.setupFromCache")

        result shouldBe SetupCommand(mockk(), mockk(), mockk(), mockk(), true)
    }

    @Test
    fun testCreate_shouldCreateASetContactCommandFromMethodCall() {
        val result = factory.create("setContact")

        result shouldBe SetContactCommand()
    }

    @Test
    fun testCreate_shouldCreateAClearContactCommandFromMethodCall() {
        val result = factory.create("clearContact")

        result shouldBe ClearContactCommand()
    }

    @Test
    fun testCreate_shouldCreateAnInitializeCommandFromMethodCall() {
        val result = factory.create("android.initialize")

        result shouldBe InitializeCommand(mockk(), mockk())
    }

    @Test
    fun testCreate_shouldCreateAClearPushTokenCommandFromMethodCall() {
        val result = factory.create("push.pushSendingEnabled")

        result shouldBe PushSendingEnabledCommand(mockk())
    }

    @Test
    fun testCreate_shouldCreateAChangeApplicationCodeCommandFromMethodCall() {
        val result = factory.create("config.changeApplicationCode")

        result shouldBe ChangeApplicationCodeCommand(mockk())
    }

    @Test
    fun testCreate_shouldCreateAnApplicationCodeCommandFromMethodCall() {
        val result = factory.create("config.applicationCode")

        result shouldBe ApplicationCodeCommand()
    }

    @Test
    fun testCreate_shouldCreateAMerchantIdCommandFromMethodCall() {
        val result = factory.create("config.merchantId")

        result shouldBe MerchantIdCommand()
    }

    @Test
    fun testCreate_shouldCreateAContactFieldIdCommandFromMethodCall() {
        val result = factory.create("config.contactFieldId")

        result shouldBe ContactFieldIdCommand()
    }

    @Test
    fun testCreate_shouldCreateAHardwareIdCommandFromMethodCall() {
        val result = factory.create("config.hardwareId")

        result shouldBe HardwareIdCommand()
    }

    @Test
    fun testCreate_shouldCreateALanguageCodeCommandFromMethodCall() {
        val result = factory.create("config.languageCode")

        result shouldBe LanguageCodeCommand()
    }

    @Test
    fun testCreate_shouldCreateANotificationSettingsCommandFromMethodCall() {
        val result = factory.create("config.notificationSettings")

        result shouldBe NotificationSettingsCommand()
    }

    @Test
    fun testCreate_shouldCreateASdkVersionCommandFromMethodCall() {
        val result = factory.create("config.sdkVersion")

        result shouldBe SdkVersionCommand()
    }

    @Test
    fun testCreate_shouldCreateTrackCustomEventCommandFromMethodCall() {
        val result = factory.create("trackCustomEvent")

        result shouldBe TrackCustomEventCommand()
    }

    @Test
    fun testCreate_shouldCreateFetchMessagesCommandFromMethodCall() {
        val result = factory.create("inbox.fetchMessages")

        result shouldBe FetchMessagesCommand(mockk())
    }

    @Test
    fun testCreate_shouldCreateAddTagCommandFromMethodCall() {
        val result = factory.create("inbox.addTag")

        result shouldBe AddTagCommand()
    }

    @Test
    fun testCreate_shouldCreateRemoveTagCommandFromMethodCall() {
        val result = factory.create("inbox.removeTag")

        result shouldBe RemoveTagCommand()
    }

    @Test
    fun testCreate_shouldCreateGeofenceEnableCommandFromMethodCall() {
        val result = factory.create("geofence.enable")

        result shouldBe GeofenceEnableCommand()
    }

    @Test
    fun testCreate_shouldCreateGeofenceDisableCommandFromMethodCall() {
        val result = factory.create("geofence.disable")

        result shouldBe GeofenceDisableCommand()
    }

    @Test
    fun testCreate_shouldCreateGeofenceInitialEnterTriggerEnabledCommandFromMethodCall() {
        val result = factory.create("geofence.initialEnterTriggerEnabled")

        result shouldBe GeofenceInitialEnterTriggerEnabledCommand()
    }

    @Test
    fun testCreate_shouldCreateGeofenceIsEnabledCommandFromMethodCall() {
        val result = factory.create("geofence.isEnabled")

        result shouldBe GeofenceIsEnabledCommand()
    }

    @Test
    fun testCreate_shouldCreateInAppResumeFromMethodCall() {
        val result = factory.create("inApp.resume")

        result shouldBe InAppResumeCommand()
    }

    @Test
    fun testCreate_shouldCreateInAppPauseFromMethodCall() {
        val result = factory.create("inApp.pause")

        result shouldBe InAppPauseCommand()
    }

    @Test
    fun testCreate_shouldCreateInAppIsPausedCommandFromMethodCall() {
        val result = factory.create("inApp.isPaused")

        result shouldBe InAppIsPausedCommand()
    }

    @Test
    fun testCreate_shouldReturnNull_whenNoCommandFound() {
        val result = factory.create("invalidCommand")

        result shouldBe null
    }
}