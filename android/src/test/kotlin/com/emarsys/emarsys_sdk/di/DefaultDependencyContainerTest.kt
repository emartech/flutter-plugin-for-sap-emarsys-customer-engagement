package com.emarsys.emarsys_sdk.di

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import io.flutter.plugin.common.BinaryMessenger
import io.kotest.matchers.shouldBe
import io.mockk.every
import io.mockk.mockk
import org.junit.Before
import org.junit.Test

class DefaultDependencyContainerTest {

    private lateinit var mockApplication: Application
    private lateinit var mockApplicationContext: Context
    private lateinit var mockInitialMessenger: BinaryMessenger
    private lateinit var mockReattachedMessenger: BinaryMessenger

    @Before
    fun setUp() {
        mockApplication = mockk(relaxed = true)
        mockApplicationContext = mockk(relaxed = true)
        mockInitialMessenger = mockk(relaxed = true)
        mockReattachedMessenger = mockk(relaxed = true)

        every { mockApplication.applicationContext } returns mockApplicationContext
        every { mockApplication.getSharedPreferences(any(), any()) } returns mockk<SharedPreferences>(relaxed = true)
    }

    @Test
    fun messenger_shouldExposeInitialBinaryMessenger() {
        val container = DefaultDependencyContainer(mockApplication, mockInitialMessenger)

        container.messenger shouldBe mockInitialMessenger
    }

    @Test
    fun messenger_shouldExposeReattachedBinaryMessenger_afterEngineReattach() {
        val container = DefaultDependencyContainer(mockApplication, mockInitialMessenger)

        container.messenger = mockReattachedMessenger

        container.messenger shouldBe mockReattachedMessenger
    }

    @Test
    fun inlineInAppViewFactory_shouldBeCachedSingleton_acrossMessengerUpdates() {
        val container = DefaultDependencyContainer(mockApplication, mockInitialMessenger)

        val factoryBeforeReattach = container.inlineInAppViewFactory
        container.messenger = mockReattachedMessenger
        val factoryAfterReattach = container.inlineInAppViewFactory

        factoryAfterReattach shouldBe factoryBeforeReattach
    }
}
