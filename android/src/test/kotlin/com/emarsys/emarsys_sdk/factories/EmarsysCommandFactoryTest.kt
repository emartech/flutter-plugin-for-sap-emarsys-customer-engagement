package com.emarsys.emarsys_sdk.factories

import com.emarsys.emarsys_sdk.commands.*
import com.emarsys.emarsys_sdk.commands.config.*
import com.emarsys.emarsys_sdk.commands.push.ClearPushTokenCommand
import com.emarsys.emarsys_sdk.commands.push.SetPushTokenCommand
import io.kotlintest.shouldBe
import org.junit.Before
import org.junit.Test

class EmarsysCommandFactoryTest {
    private lateinit var factory: EmarsysCommandFactory

    @Before
    fun setUp() {
        factory = EmarsysCommandFactory()
    }

    @Test
    fun testCreate_shouldCreateASetupCommandFromMethodCall() {
        val result = factory.create("setup")

        result shouldBe SetupCommand()
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

        result shouldBe InitializeCommand()
    }

    @Test
    fun testCreate_shouldCreateAClearPushTokenCommandFromMethodCall() {
        val result = factory.create("push.clearPushToken")

        result shouldBe ClearPushTokenCommand()
    }

    @Test
    fun testCreate_shouldCreateASetPushTokenCommandFromMethodCall() {
        val result = factory.create("push.setPushToken")

        result shouldBe SetPushTokenCommand()
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
    fun testCreate_shouldCreateAPushSettingsCommandFromMethodCall() {
        val result = factory.create("config.pushSettings")

        result shouldBe PushSettingsCommand()
    }

    @Test
    fun testCreate_shouldCreateASdkVersionCommandFromMethodCall() {
        val result = factory.create("config.sdkVersion")

        result shouldBe SdkVersionCommand()
    }

    @Test
    fun testCreate_shouldCreateAIsAutomaticPushSendingEnabledCommandFromMethodCall() {
        val result = factory.create("config.android.isAutomaticPushSendingEnabled")

        result shouldBe IsAutomaticPushSendingEnabledCommand()
    }

    @Test
    fun testCreate_shouldReturnNull_whenNoCommandFound() {
        val result = factory.create("invalidCommand")

        result shouldBe null
    }
}