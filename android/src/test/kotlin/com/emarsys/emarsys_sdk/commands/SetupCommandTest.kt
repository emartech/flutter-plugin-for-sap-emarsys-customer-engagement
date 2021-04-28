package com.emarsys.emarsys_sdk.commands

import android.app.Application
import com.emarsys.Emarsys
import com.emarsys.config.EmarsysConfig
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
    }

    private lateinit var setupCommand: SetupCommand
    private lateinit var mockApplication: Application

    @Before
    fun setUp() {
        setupCommand = SetupCommand()
        mockApplication = mockk(relaxed = true)

        mockkStatic(Emarsys::class)
        every { Emarsys.setup(any()) } just Runs

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

        setupCommand.execute(parameters) { success, error ->

        }

    }

    @Test(expected = IllegalArgumentException::class)
    fun testExecute_parametersMustNotBeNull() {
        setupCommand.execute(null) { success, error ->

        }
    }

    @Test
    fun testExecute_shouldCallEmarsysSetupWithAllConfigValuesFromParametersMap() {
        val parameters = mapOf(
                "contactFieldId" to CONTACT_FIELD_ID,
                "mobileEngageApplicationCode" to APP_CODE,
                "predictMerchantId" to MERCHANT_ID,
                "androidAutomaticPushTokenSending" to true,
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

        setupCommand.execute(parameters) { success, error ->

        }

        verify { Emarsys.setup(expectedConfig) }
    }
}