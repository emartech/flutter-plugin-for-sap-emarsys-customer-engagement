package com.emarsys.emarsys_sdk.factories

import com.emarsys.emarsys_sdk.commands.*
import com.emarsys.emarsys_sdk.commands.config.*
import com.emarsys.emarsys_sdk.commands.push.PushSendingEnabledCommand
import io.kotlintest.shouldBe
import io.mockk.mockk
import org.junit.Before
import org.junit.Test

class EmarsysCommandFactoryTest {
    private lateinit var factory: EmarsysCommandFactory

    @Before
    fun setUp() {
        factory = EmarsysCommandFactory(mockk(), mockk(), mockk(), mockk())
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

        result shouldBe InitializeCommand(mockk())
    }

    @Test
    fun testCreate_shouldCreateAClearPushTokenCommandFromMethodCall() {
        val result = factory.create("push.pushSendingEnabled")

        result shouldBe PushSendingEnabledCommand(mockk())
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
    fun testCreate_shouldReturnNull_whenNoCommandFound() {
        val result = factory.create("invalidCommand")

        result shouldBe null
    }
}