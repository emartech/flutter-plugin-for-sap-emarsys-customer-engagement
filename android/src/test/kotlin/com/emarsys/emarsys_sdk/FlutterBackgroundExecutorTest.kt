package com.emarsys.emarsys_sdk

import android.app.Application
import android.content.SharedPreferences
import android.os.Handler
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.commands.SetupCommandTest
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.di.tearDownDependencyContainer
import com.emarsys.emarsys_sdk.provider.MainHandlerProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class FlutterBackgroundExecutorTest {
    companion object {
        const val APP_CODE = "testAppCode"
        const val CONTACT_FIELD_ID = 2
        const val MERCHANT_ID = "testMerchantId"
        val SHARED_PACKAGE_NAMES = mutableSetOf("shared1", "shared2")
        const val SECRET = "testSecret"
    }

    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var mockApplication: Application

    private lateinit var flutterBackgroundExecutor: FlutterBackgroundExecutor

    @Before
    fun setUp() {
        val mockMainHandlerProvider: MainHandlerProvider = mockk()
        val mockMainHandler: Handler = mockk()
        every { mockMainHandlerProvider.provide() } returns mockMainHandler
        every { mockMainHandler.post(any()) } answers {
            firstArg<Runnable>().run()
            true
        }
        mockSharedPreferences = mockk(relaxed = true)
        mockApplication = mockk(relaxed = true)
        mockkStatic(Emarsys::class)
        every { Emarsys.setup(any()) } just Runs

        mockkObject(EmarsysMessagingService)
        every { EmarsysMessagingService.showInitialMessages(any()) } just Runs

        flutterBackgroundExecutor = FlutterBackgroundExecutor(mockApplication)
        setupDependencyContainer(
            FakeDependencyContainer(
                sharedPreferences = mockSharedPreferences,
                mainHandlerProvider = mockMainHandlerProvider
            )
        )
    }

    @After
    fun tearDown() {
        tearDownDependencyContainer()

        clearAllMocks()
        unmockkObject(EmarsysMessagingService)
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testOnMethodCall_callSetupWithStoredConfig() {
        val mockResult: MethodChannel.Result = mockk(relaxed = true)

        every {
            mockSharedPreferences.getString(
                ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                any()
            )
        } returns APP_CODE
        every {
            mockSharedPreferences.getInt(
                ConfigStorageKeys.CONTACT_FIELD_ID.name,
                any()
            )
        } returns CONTACT_FIELD_ID
        every {
            mockSharedPreferences.getString(
                ConfigStorageKeys.PREDICT_MERCHANT_ID.name,
                any()
            )
        } returns MERCHANT_ID
        every {
            mockSharedPreferences.getString(
                ConfigStorageKeys.ANDROID_SHARED_SECRET.name,
                any()
            )
        } returns SECRET
        every {
            mockSharedPreferences.getStringSet(
                ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name,
                any()
            )
        } returns SHARED_PACKAGE_NAMES
        every {
            mockSharedPreferences.getBoolean(
                ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
                any()
            )
        } returns false
        every {
            mockSharedPreferences.getBoolean(
                ConfigStorageKeys.ANDROID_DISABLE_AUTOMATIC_PUSH_TOKEN_SENDING.name,
                any()
            )
        } returns false

        val expectedConfig = EmarsysConfig.Builder()
            .application(mockApplication)
            .contactFieldId(SetupCommandTest.CONTACT_FIELD_ID)
            .mobileEngageApplicationCode(SetupCommandTest.APP_CODE)
            .predictMerchantId(SetupCommandTest.MERCHANT_ID)
            .sharedPackageNames(SetupCommandTest.SHARED_PACKAGE_NAMES)
            .sharedSecret(SetupCommandTest.SECRET)
            .build()

        flutterBackgroundExecutor.onMethodCall(
            MethodCall("android.setupFromCache", mockk()),
            mockResult
        )


        verify { Emarsys.setup(expectedConfig) }
        verify { EmarsysMessagingService.showInitialMessages(mockApplication) }
        verify { mockResult.success(true) }
    }

    @Test
    fun testOnMethodCall_notInitializedCall() {
        val mockResult: MethodChannel.Result = mockk(relaxed = true)

        flutterBackgroundExecutor.onMethodCall(MethodCall("NOT_INITIALIZED", mockk()), mockResult)

        verify { mockResult.notImplemented() }
    }

}