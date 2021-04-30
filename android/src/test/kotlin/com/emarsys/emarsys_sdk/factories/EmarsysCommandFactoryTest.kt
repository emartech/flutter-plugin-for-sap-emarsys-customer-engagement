package com.emarsys.emarsys_sdk.factories

import com.emarsys.emarsys_sdk.commands.ClearContactCommand
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.commands.SetContactCommand
import com.emarsys.emarsys_sdk.commands.SetupCommand
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
    fun testCreate_shouldThrowUnimplementedException_whenNoCommandFound() {
        val result = factory.create("invalidCommand")

        result shouldBe null
    }
}