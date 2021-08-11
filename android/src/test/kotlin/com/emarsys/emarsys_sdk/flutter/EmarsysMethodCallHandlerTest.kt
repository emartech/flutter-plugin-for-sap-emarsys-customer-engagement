package com.emarsys.emarsys_sdk.flutter

import com.emarsys.emarsys_sdk.command.EmarsysCommandFactory
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.command.mobileengage.contact.ClearContactCommand
import com.emarsys.emarsys_sdk.command.setup.SetupCommand
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.di.tearDownDependencyContainer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.mockk.*
import org.json.JSONObject
import org.junit.After
import org.junit.Before
import org.junit.Test

class EmarsysMethodCallHandlerTest {

    private lateinit var emarsysMethodCallHandler: EmarsysMethodCallHandler
    private lateinit var mockCommandFactory: EmarsysCommandFactory

    @Before
    fun setUp() {
        emarsysMethodCallHandler = EmarsysMethodCallHandler(mockk())

        mockCommandFactory = mockk(relaxed = true)
        setupDependencyContainer(FakeDependencyContainer(emarsysCommandFactory = mockCommandFactory))
    }

    @After
    fun tearDown() {
        tearDownDependencyContainer()
        clearAllMocks()
    }


    @Test
    fun testOnMethodCall_shouldCallFactory() {
        emarsysMethodCallHandler.onMethodCall(
            MethodCall("testMethodName", mapOf<String, Any>()),
            mockk()
        )

        verify { mockCommandFactory.create(any()) }
    }

    @Test
    fun testOnMethodCall_shouldCallFactoryWithTheMethodCallsMethodName() {
        emarsysMethodCallHandler.onMethodCall(MethodCall("setup", mapOf<String, Any>()), mockk())

        verify { mockCommandFactory.create(eq("setup")) }
    }

    @Test
    fun testOnMethodCall_shouldExecuteCommandCreatedByFactoryWithCorrectArguments() {
        val mockCommand: SetupCommand = mockk(relaxed = true)
        val expectedArguments = mapOf(
            "arg1" to "value1",
            "arg2" to "value2"
        )

        every {
            mockCommandFactory.create("setup")
        } returns mockCommand

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "setup",
                expectedArguments
            ),
            mockk()
        )

        verify { mockCommandFactory.create(eq("setup")) }
        verify { mockCommand.execute(expectedArguments, any()) }
    }

    @Test(expected = IllegalArgumentException::class)
    fun testOnMethodCall_shouldNotExecuteCommandCreatedByFactoryWithCorrectArguments_whenArgumentsAreNotAMap() {
        val mockCommand: SetupCommand = mockk(relaxed = true)
        val expectedArguments = JSONObject(
            mapOf(
                "arg1" to "value1",
                "arg2" to "value2"
            )
        )

        every {
            mockCommandFactory.create("setup")
        } returns mockCommand

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "setup",
                expectedArguments
            ),
            mockk()
        )

        verify { mockCommand wasNot Called }
        verify { mockCommandFactory wasNot Called }
    }

    @Test
    fun testOnMethodCall_shouldExecuteCommandCreatedByFactoryWithCorrectArguments_whenArgumentsAreNull() {
        val mockCommand: ClearContactCommand = mockk(relaxed = true)

        every {
            mockCommandFactory.create("clearContact")
        } returns mockCommand

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "clearContact",
                null
            ),
            mockk()
        )

        verify { mockCommandFactory.create("clearContact") }
        verify { mockCommand.execute(null, any()) }
    }

    @Test
    fun testOnMethodCall_shouldCallResultError_whenResultCallbackContainsError() {
        val mockResult: MethodChannel.Result = mockk(relaxed = true)
        val mockCommand: SetupCommand = mockk(relaxed = true)
        val testError = RuntimeException("testErrorMessage")

        val expectedArguments = mapOf("arg1" to "value1", "arg2" to "value2")

        every {
            mockCommandFactory.create("setup")
        } returns mockCommand

        every {
            mockCommand.execute(any(), any())
        } answers { call ->
            (call.invocation.args[1] as ResultCallback).invoke(null, testError)
        }

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "setup",
                expectedArguments
            ),
            mockResult
        )

        verify { mockResult.error("EMARSYS_SDK_ERROR", "testErrorMessage", testError) }
    }

    @Test
    fun testOnMethodCall_shouldCallSuccessWithResult_whenResultCallbackDoesNotContainsError() {
        val mockResult: MethodChannel.Result = mockk(relaxed = true)
        val mockCommand: SetupCommand = mockk(relaxed = true)

        val expectedArguments = mapOf("arg1" to "value1", "arg2" to "value2")

        every {
            mockCommandFactory.create("setup")
        } returns mockCommand

        every {
            mockCommand.execute(any(), any())
        } answers { call ->
            (call.invocation.args[1] as ResultCallback).invoke(Any(), null)
        }

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "setup",
                expectedArguments
            ),
            mockResult
        )

        verify { mockResult.success(any()) }
    }

    @Test
    fun testOnMethodCall_shouldCallResultNotImplemented_whenNoCommandIsCreatedByFactory() {
        val mockResult: MethodChannel.Result = mockk(relaxed = true)

        every {
            mockCommandFactory.create(any())
        } returns null

        emarsysMethodCallHandler.onMethodCall(
            MethodCall(
                "notImplementedMethod",
                mapOf<String, Any>()
            ),
            mockResult
        )

        verify { mockResult.notImplemented() }
    }
}