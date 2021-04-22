package com.emarsys.emarsys_sdk

import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.di.DependencyInjection
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import io.flutter.plugin.common.MethodCall
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class EmarsysSdkPluginTest {
    private lateinit var emarsysPlugin: EmarsysSdkPlugin
    private lateinit var mockCommandFactory: EmarsysCommandFactory

    @Before
    fun setUp() {
        emarsysPlugin = EmarsysSdkPlugin()
        mockCommandFactory = mockk(relaxed = true)
        DependencyInjection.setup(FakeDependencyContainer(mockCommandFactory))
    }

    @Test
    fun testOnMethodCall_shouldCallFactory() {
        emarsysPlugin.onMethodCall(MethodCall("testMethodName", mapOf<String, Any>()), mockk())

        verify { mockCommandFactory.create(any()) }
    }
}