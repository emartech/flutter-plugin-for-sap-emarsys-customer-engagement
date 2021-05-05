package com.emarsys.emarsys_sdk.commands

import android.app.Application
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.PushTokenHolder
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
    private lateinit var mockPushTokenHolder: PushTokenHolder

    @Before
    fun setUp() {
        setupCommand = SetupCommand()
        mockPushTokenHolder = PushTokenHolder
        mockApplication = mockk(relaxed = true)
        mockkObject(mockPushTokenHolder)
        every { mockPushTokenHolder.pushToken } returns PUSH_TOKEN

        mockkStatic(Emarsys::class)
        every { Emarsys.setup(any()) } just Runs
        every { Emarsys.push.pushToken = any() } just Runs

        setupDependencyContainer(FakeDependencyContainer(application = mockApplication))
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

        verify { Emarsys.setup(expectedConfig) }
        verify { Emarsys.push.pushToken = PUSH_TOKEN }
    }

    @Test
    fun testExecute_shouldSetPushTokenFromObserver_whenPushTokenHolderContainsNull() {
        every { mockPushTokenHolder.pushToken } returns null
        every { mockPushTokenHolder.pushToken = any() } answers {
            mockPushTokenHolder.pushTokenObserver?.invoke(firstArg())
        }

        val expectedConfig = EmarsysConfig.Builder()
                .application(mockApplication)
                .contactFieldId(CONTACT_FIELD_ID)
                .build()

        setupCommand.execute(mapOf("contactFieldId" to CONTACT_FIELD_ID)) { _, _ ->

        }

        mockPushTokenHolder.pushToken = "localTestPushToken"

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

        setupCommand.execute(mapOf("contactFieldId" to CONTACT_FIELD_ID,
                "androidDisableAutomaticPushTokenSending" to true)) { _, _ ->
        }


        verify { Emarsys.setup(expectedConfig) }
        verify(exactly = 0) { Emarsys.push.pushToken }
    }
}