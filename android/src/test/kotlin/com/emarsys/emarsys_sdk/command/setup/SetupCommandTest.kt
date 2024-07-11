package com.emarsys.emarsys_sdk.command.setup

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.common.feature.InnerFeature
import com.emarsys.config.EmarsysConfig
import com.emarsys.core.feature.FeatureRegistry
import com.emarsys.core.provider.wrapper.WrapperInfoContainer
import com.emarsys.di.emarsys
import com.emarsys.di.isEmarsysComponentSetup
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.dependencyContainer
import com.emarsys.emarsys_sdk.di.tearDownDependencyContainer
import com.emarsys.emarsys_sdk.storage.PushTokenStorage
import com.emarsys.mobileengage.api.event.EventHandler
import com.emarsys.push.PushApi
import io.kotest.matchers.shouldBe
import io.mockk.Runs
import io.mockk.clearAllMocks
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.spyk
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetupCommandTest {
    companion object {
        const val APP_CODE = "testAppCode"
        const val MERCHANT_ID = "testMerchantId"
        val SHARED_PACKAGE_NAMES = listOf("shared1", "shared2")
        const val SECRET = "testSecret"
        const val PUSH_TOKEN = "testPushToken"
    }

    private lateinit var setupCommand: SetupCommand
    private lateinit var mockApplication: Application
    private lateinit var mockPushTokenStorage: PushTokenStorage
    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var mockEdit: SharedPreferences.Editor
    private lateinit var mockPushEventHandler: EventHandler
    private lateinit var mockSilentPushEventHandler: EventHandler
    private lateinit var mockGeofenceEventHandler: EventHandler
    private lateinit var mockInAppEventHandler: EventHandler
    private lateinit var mockPushApi: PushApi

    @Before
    fun setUp() {
        mockPushTokenStorage = mockk(relaxed = true)
        mockPushApi = mockk(relaxed = true)
        mockApplication = mockk(relaxed = true)
        mockSharedPreferences = mockk(relaxed = true)
        mockEdit = mockk(relaxed = true)
        mockPushEventHandler = mockk(relaxed = true)
        mockSilentPushEventHandler = mockk(relaxed = true)
        mockGeofenceEventHandler = mockk(relaxed = true)
        mockInAppEventHandler = mockk(relaxed = true)

        mockkStatic("com.emarsys.emarsys_sdk.di.DependencyContainerKt")
        mockkStatic("com.emarsys.di.EmarsysComponentKt")
        mockkStatic(Emarsys::class)
        mockkStatic(FeatureRegistry::class)

        setupCommand = SetupCommand(
            mockApplication,
            mockPushTokenStorage,
            mockSharedPreferences,
            false
        )

        every { mockPushTokenStorage.pushToken } returns PUSH_TOKEN
        every { mockPushTokenStorage.enabled } returns true

        every { dependencyContainer().currentActivityHolder.currentActivity } returns mockk(relaxed = true)

        every { dependencyContainer().pushEventHandler } returns mockPushEventHandler
        every { dependencyContainer().silentPushEventHandler } returns mockSilentPushEventHandler
        every { dependencyContainer().geofenceEventHandler } returns mockGeofenceEventHandler
        every { dependencyContainer().inAppEventHandler } returns mockInAppEventHandler

        every { isEmarsysComponentSetup() } returns true
        every { emarsys().currentActivityProvider.set(any()) } just Runs
        every { emarsys().activityLifecycleActionRegistry.execute(null, any()) } just Runs
        every { Emarsys.trackCustomEvent(any(), any()) } just Runs
        every { mockSharedPreferences.edit() } returns mockEdit
        every { Emarsys.setup(any()) } just Runs
        every { FeatureRegistry.enableFeature(any()) } just Runs
        every {
            mockApplication.getSharedPreferences(
                "emarsys_setup_cache",
                0
            )
        } returns mockSharedPreferences

        every { Emarsys.push } returns mockPushApi
        every { Emarsys.push.pushToken = any() } just Runs
        every { Emarsys.push.setPushToken(any(), any()) } just Runs
        every { Emarsys.push.setNotificationEventHandler(any()) } just Runs
        every { Emarsys.push.setSilentMessageEventHandler(any()) } just Runs
        every { Emarsys.geofence.setEventHandler(any()) } just Runs
        every { Emarsys.inApp.setEventHandler(any()) } just Runs
    }


    @After
    fun tearDown() {
        tearDownDependencyContainer()

        clearAllMocks()

        WrapperInfoContainer.wrapperInfo = null
    }

    @Test
    fun testExecute_parametersMustNotBeNull_ifSetupCalled_notFromCache() {
        var calls = 0
        var exception: Throwable? = null
        val resultCallback: ResultCallback = { _, error ->
            exception = error
            calls++
        }
        setupCommand.execute(null, resultCallback)

        calls shouldBe 1
        exception!!::class shouldBe IllegalArgumentException::class
    }

    @Test
    fun testExecute_ifSetupCalled_fromCache_shouldCallResultCallback_withoutException() {
        var calls = 0
        var exception: Throwable? = null
        val resultCallback: ResultCallback = { _, error ->
            exception = error
            calls++
        }
        val testCommand = SetupCommand(
            mockApplication,
            mockPushTokenStorage,
            mockSharedPreferences,
            true
        )

        testCommand.execute(null, resultCallback)

        exception shouldBe null
        calls shouldBe 1
    }

    @Test
    fun testExecute_shouldCallEmarsysSetupWithAllConfigValuesFromParametersMap() {
        val parameters = mapOf(
            "applicationCode" to APP_CODE,
            "merchantId" to MERCHANT_ID,
            "androidSharedPackageNames" to SHARED_PACKAGE_NAMES,
            "androidSharedSecret" to SECRET,
            "androidVerboseConsoleLoggingEnabled" to true
        )

        val expectedConfig = EmarsysConfig(
            application = mockApplication,
            applicationCode = APP_CODE,
            merchantId = MERCHANT_ID,
            sharedPackageNames = SHARED_PACKAGE_NAMES,
            sharedSecret = SECRET,
            verboseConsoleLoggingEnabled = true
        )

        setupCommand.execute(parameters) { _, _ ->

        }
        mockSharedPreferences.edit()

        verify {
            mockEdit.putString(
                ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                APP_CODE
            )
        }
        verify { mockEdit.putString(ConfigStorageKeys.PREDICT_MERCHANT_ID.name, MERCHANT_ID) }
        verify {
            mockEdit.putStringSet(
                ConfigStorageKeys.ANDROID_SHARED_PACKAGE_NAMES.name,
                mutableSetOf(*SHARED_PACKAGE_NAMES.toTypedArray())
            )
        }
        verify { mockEdit.putString(ConfigStorageKeys.ANDROID_SHARED_SECRET.name, SECRET) }
        verify {
            mockEdit.putBoolean(
                ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
                true
            )
        }

        verify { mockEdit.apply() }
        verify { Emarsys.setup(expectedConfig) }
        verify { FeatureRegistry.enableFeature(InnerFeature.APP_EVENT_CACHE) }
        verify { Emarsys.push.pushToken = PUSH_TOKEN }
        verify { Emarsys.push.setNotificationEventHandler(mockPushEventHandler) }
        verify { Emarsys.push.setSilentMessageEventHandler(mockSilentPushEventHandler) }
        verify { Emarsys.geofence.setEventHandler(mockGeofenceEventHandler) }
        verify { Emarsys.inApp.setEventHandler(mockInAppEventHandler) }
    }

    @Test
    fun testExecute_shouldSetPushTokenFromObserver_whenPushTokenStorageContainsNull() {
        every { mockSharedPreferences.getString("push_token", any()) } returns null
        every { mockSharedPreferences.getBoolean("push_sending_enabled", any()) } returns true
        val pushTokenStorage = spyk(PushTokenStorage(mockSharedPreferences))
        val setupCommand = SetupCommand(
            mockApplication,
            pushTokenStorage,
            mockSharedPreferences,
            false
        )


        val expectedConfig = EmarsysConfig(
            application = mockApplication,
        )
        setupCommand.execute(mapOf()) { _, _ ->

        }

        pushTokenStorage.pushToken = "localTestPushToken"

        verify { Emarsys.setup(expectedConfig) }
        verify { FeatureRegistry.enableFeature(InnerFeature.APP_EVENT_CACHE) }
        verify { Emarsys.push.pushToken = "localTestPushToken" }
    }

    @Test
    fun testExecute_notSetPushToken_whenDisabled() {
        val mockPushApi: PushApi = mockk(relaxed = true)
        every { Emarsys.push } returns mockPushApi

        val setupCommand = SetupCommand(
            mockApplication,
            PushTokenStorage(mockSharedPreferences),
            mockSharedPreferences,
            false
        )
        every { mockPushTokenStorage.pushToken } returns null
        every { mockPushTokenStorage.enabled } returns false

        val expectedConfig = EmarsysConfig(
            application = mockApplication
        )
        setupCommand.execute(mapOf()) { _, _ ->

        }

        verify { Emarsys.setup(expectedConfig) }
        verify { FeatureRegistry.enableFeature(InnerFeature.APP_EVENT_CACHE) }
        verify(exactly = 0) { mockPushApi.setPushToken(any(), any()) }
    }

    @Test
    fun testOnMethodCall_callSetupWithStoredConfig() {
        setupCommand = SetupCommand(
            mockApplication,
            mockPushTokenStorage,
            mockSharedPreferences,
            true
        )

        every {
            mockSharedPreferences.getString(
                ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                any()
            )
        } returns APP_CODE
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
        } returns mutableSetOf(*SHARED_PACKAGE_NAMES.toTypedArray())
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

        val expectedConfig = EmarsysConfig(
            application = mockApplication,
            applicationCode = APP_CODE,
            merchantId = MERCHANT_ID,
            sharedPackageNames = SHARED_PACKAGE_NAMES,
            sharedSecret = SECRET
        )

        setupCommand.execute(mapOf()) { _, _ ->

        }

        verify { Emarsys.setup(expectedConfig) }
        verify { FeatureRegistry.enableFeature(InnerFeature.APP_EVENT_CACHE) }
        verify { Emarsys.push.pushToken = PUSH_TOKEN }
        verify(exactly = 0) { mockPushApi.setNotificationEventHandler(mockPushEventHandler) }
        verify(exactly = 0) { mockPushApi.setSilentMessageEventHandler(mockSilentPushEventHandler) }
        verify(exactly = 0) { Emarsys.geofence.setEventHandler(mockGeofenceEventHandler) }
        verify(exactly = 0) { Emarsys.inApp.setEventHandler(mockInAppEventHandler) }
    }

    @Test
    fun testExecute_shouldCallTrackCustomEvent_withCorrectInitData_whenSetupHasNotBeenCalledPreviously() {
        every { isEmarsysComponentSetup() } returns false

        setupCommand.execute(mapOf()) { _, _ ->
        }

        verify { Emarsys.trackCustomEvent("wrapper:init", mapOf("type" to "flutter")) }
    }

    @Test
    fun testExecute_shouldNotCallTrackCustomEvent_whenSetupHasBeenCalledPreviously() {
        every { Emarsys.trackCustomEvent(any(), any()) } just Runs

        setupCommand.execute(mapOf()) { _, _ ->
        }

        verify(exactly = 0) { Emarsys.trackCustomEvent("sdk:init", mapOf("wrapper" to "flutter")) }
    }

    @Test
    fun testExecute_shouldSetFlutterToWrapperInfoContainer() {
        WrapperInfoContainer.wrapperInfo shouldBe null

        setupCommand.execute(mapOf()) { _, _ ->
        }

        val result = WrapperInfoContainer.wrapperInfo

        result shouldBe "flutter"
    }
}