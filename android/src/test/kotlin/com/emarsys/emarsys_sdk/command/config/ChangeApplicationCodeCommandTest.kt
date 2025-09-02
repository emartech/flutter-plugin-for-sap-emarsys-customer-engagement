package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.config.ConfigApi
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import com.emarsys.emarsys_sdk.di.FakeDependencyContainer
import com.emarsys.emarsys_sdk.di.setupDependencyContainer
import com.emarsys.geofence.GeofenceApi
import com.emarsys.inapp.InAppApi
import com.emarsys.mobileengage.api.event.EventHandler
import com.emarsys.push.PushApi
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class ChangeApplicationCodeCommandTest {
    companion object {
        private const val APP_CODE = "testApplicationCode"
    }

    private lateinit var mockConfigApi: ConfigApi
    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var mockEdit: SharedPreferences.Editor
    private lateinit var mockResultCallback: ResultCallback
    private lateinit var mockPushEventHandler: EventHandler
    private lateinit var mockSilentPushEventHandler: EventHandler
    private lateinit var mockInAppEventHandler: EventHandler
    private lateinit var mockGeofenceEventHandler: EventHandler
    private lateinit var mockPushApi: PushApi
    private lateinit var mockInAppApi: InAppApi
    private lateinit var mockGeofenceApi: GeofenceApi
    private lateinit var command: ChangeApplicationCodeCommand

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        mockPushEventHandler = mockk(relaxed = true)
        mockSilentPushEventHandler = mockk(relaxed = true)
        mockInAppEventHandler = mockk(relaxed = true)
        mockGeofenceEventHandler = mockk(relaxed = true)
        mockSharedPreferences = mockk(relaxed = true)
        val fakeDependencyContainer = FakeDependencyContainer(
            pushEventHandler = mockPushEventHandler,
            silentPushEventHandler = mockSilentPushEventHandler,
            inAppEventHandler = mockInAppEventHandler,
            geofenceEventHandler = mockGeofenceEventHandler
        )
        setupDependencyContainer(fakeDependencyContainer)

        mockConfigApi = mockk()
        mockPushApi = mockk(relaxed = true)
        mockInAppApi = mockk(relaxed = true)
        mockGeofenceApi = mockk(relaxed = true)
        mockEdit = mockk(relaxed = true)
        mockResultCallback = mockk(relaxed = true)

        every { mockSharedPreferences.edit() } returns mockEdit
        every { Emarsys.config } returns mockConfigApi
        every { Emarsys.push } returns mockPushApi
        every { Emarsys.inApp } returns mockInAppApi
        every { Emarsys.geofence } returns mockGeofenceApi

        command = ChangeApplicationCodeCommand(mockSharedPreferences)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallResultCallbackWithError_whenApplicationCodeIsNotPresentInParametersMap() {
        every { mockConfigApi.changeApplicationCode(any()) } just Runs

        command.execute(mapOf(), mockResultCallback)

        verify(exactly = 0) { mockConfigApi.changeApplicationCode(any(), any()) }
        verify { mockResultCallback.invoke(null, any<IllegalArgumentException>()) }
    }

    @Test
    fun testExecute_shouldInvokeChangeAppCodeOnEmarsys() {
        every { mockConfigApi.changeApplicationCode(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(null)
        }
        every { mockEdit.putString(any(), any()) } returns mockEdit

        command.execute(mapOf("applicationCode" to APP_CODE), mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
        verify { mockConfigApi.changeApplicationCode(APP_CODE, any()) }
        verify {
            mockEdit.putString(
                ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                APP_CODE
            )
        }
        verify { mockEdit.apply() }
        verify { mockPushApi.setNotificationEventHandler(mockPushEventHandler) }
        verify { mockPushApi.setSilentMessageEventHandler(mockSilentPushEventHandler) }
        verify { mockInAppApi.setEventHandler(mockInAppEventHandler) }
        verify { mockGeofenceApi.setEventHandler(mockGeofenceEventHandler) }
    }

    @Test
    fun testExecute_shouldInvokeChangeAppCodeOnEmarsys_withError() {
        val testError = Throwable()

        every { mockConfigApi.changeApplicationCode(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(testError)
        }
        every { mockEdit.remove(any()) } returns mockEdit

        command.execute(mapOf("applicationCode" to APP_CODE), mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
        verify { mockConfigApi.changeApplicationCode(APP_CODE, any()) }
        verify {
            mockEdit.remove(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name)
        }
        verify(exactly = 0) { mockPushApi.setNotificationEventHandler(mockPushEventHandler) }
        verify(exactly = 0) { mockPushApi.setSilentMessageEventHandler(mockSilentPushEventHandler) }
        verify(exactly = 0) { mockInAppApi.setEventHandler(mockInAppEventHandler) }
        verify(exactly = 0) { mockGeofenceApi.setEventHandler(mockGeofenceEventHandler) }
        verify { mockEdit.apply() }
    }
}