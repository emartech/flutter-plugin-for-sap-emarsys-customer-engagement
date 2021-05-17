package com.emarsys.emarsys_sdk.commands

import android.app.Application
import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.emarsys_sdk.PushTokenStorage
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.emarsys_sdk.di.tearDownDependencyContainer
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class SetupCommandTest {
    companion object {
        const val APP_CODE = "testAppCode"
        const val CONTACT_FIELD_ID = 2
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

    @Before
    fun setUp() {
        mockPushTokenStorage = mockk()
        setupCommand = SetupCommand(mockPushTokenStorage)
        mockApplication = mockk(relaxed = true)
        mockSharedPreferences = mockk(relaxed = true)
        mockEdit = mockk(relaxed = true)

        every { mockPushTokenStorage.pushToken } returns PUSH_TOKEN

        mockkStatic(Emarsys::class)
        every { mockSharedPreferences.edit() } returns mockEdit
        every { Emarsys.setup(any()) } just Runs
        every { Emarsys.push.pushToken = any() } just Runs

        setupDependencyContainer(
            FakeDependencyContainer(
                application = mockApplication,
                sharedPreferences = mockSharedPreferences
            )
        )
    }


    @After
    fun tearDown() {
        tearDownDependencyContainer()

        clearAllMocks()
        unmockkStatic(Emarsys::class)
    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_contactFieldValueMustNotBeNull() {
        val parameters = mapOf<String, Any>()

        setupCommand.execute(parameters) { _, _ ->

        }

    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_parametersMustNotBeNull() {
        setupCommand.execute(null) { _, _ ->
        }
    }

    @Test
    fun testExecute_shouldCallEmarsysSetupWithAllConfigValuesFromParametersMap() {
        val parameters = mapOf(
            "contactFieldId" to CONTACT_FIELD_ID,
            "mobileEngageApplicationCode" to APP_CODE,
            "predictMerchantId" to MERCHANT_ID,
            "androidDisableAutomaticPushTokenSending" to false,
            "androidSharedPackageNames" to SHARED_PACKAGE_NAMES,
            "androidSharedSecret" to SECRET,
            "androidVerboseConsoleLoggingEnabled" to true
        )

        val expectedConfig = EmarsysConfig.Builder()
            .application(mockApplication)
            .contactFieldId(CONTACT_FIELD_ID)
            .mobileEngageApplicationCode(APP_CODE)
            .predictMerchantId(MERCHANT_ID)
            .sharedPackageNames(SHARED_PACKAGE_NAMES)
            .sharedSecret(SECRET)
            .enableVerboseConsoleLogging()
            .build()

        setupCommand.execute(parameters) { _, _ ->

        }
        mockSharedPreferences.edit()

        verify { mockEdit.putInt(ConfigStorageKeys.CONTACT_FIELD_ID.name, CONTACT_FIELD_ID) }
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
                ConfigStorageKeys.ANDROID_DISABLE_AUTOMATIC_PUSH_TOKEN_SENDING.name,
                false
            )
        }
        verify {
            mockEdit.putBoolean(
                ConfigStorageKeys.ANDROID_VERBOSE_CONSOLE_LOGGING_ENABLED.name,
                true
            )
        }
        verify { mockEdit.apply() }
        verify { Emarsys.setup(expectedConfig) }
        verify { Emarsys.push.pushToken = PUSH_TOKEN }
    }

    @Test
    fun testExecute_shouldSetPushTokenFromObserver_whenPushTokenHolderContainsNull() {
        every { mockPushTokenStorage.pushToken } returns null
        every { mockPushTokenStorage.pushToken = any() } answers {
            mockPushTokenStorage.pushTokenObserver?.invoke(firstArg())
        }

        val expectedConfig = EmarsysConfig.Builder()
            .application(mockApplication)
            .contactFieldId(CONTACT_FIELD_ID)
            .build()

        setupCommand.execute(mapOf("contactFieldId" to CONTACT_FIELD_ID)) { _, _ ->

        }

        mockPushTokenStorage.pushToken = "localTestPushToken"

        verify { Emarsys.setup(expectedConfig) }
        verify { Emarsys.push.pushToken = "localTestPushToken" }
    }

    @Test
    fun testExecute_shouldNotSetPushToken_whenPushTokenSendingIsDisabled() {

        val expectedConfig = EmarsysConfig.Builder()
            .application(mockApplication)
            .disableAutomaticPushTokenSending()
            .contactFieldId(CONTACT_FIELD_ID)
            .build()

        setupCommand.execute(
            mapOf(
                "contactFieldId" to CONTACT_FIELD_ID,
                "androidDisableAutomaticPushTokenSending" to true
            )
        ) { _, _ ->
        }

        verify { Emarsys.setup(expectedConfig) }
        verify(exactly = 0) { Emarsys.push.pushToken }
    }
}