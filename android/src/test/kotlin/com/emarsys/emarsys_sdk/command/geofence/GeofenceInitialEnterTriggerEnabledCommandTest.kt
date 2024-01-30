package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.geofence.GeofenceApi
import io.kotlintest.shouldBe
import io.kotlintest.shouldNotBe
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

class GeofenceInitialEnterTriggerEnabledCommandTest {
    private lateinit var command: GeofenceInitialEnterTriggerEnabledCommand
    private lateinit var mockGeofenceApi: GeofenceApi

    @Before
    fun setUp() {
        mockGeofenceApi = mockk()
        mockkStatic(Emarsys::class)
        every { Emarsys.geofence } returns mockGeofenceApi
        command = GeofenceInitialEnterTriggerEnabledCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldDelegateCallToEmarsys() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        every { mockGeofenceApi.setInitialEnterTriggerEnabled(any()) } just Runs

        command.execute(mapOf("enabled" to true), mockResultCallback)

        verify { mockGeofenceApi.setInitialEnterTriggerEnabled(true) }
        verify { mockResultCallback.invoke(null, null) }
    }

    @Test
    fun testExecute_shouldReturnWithError() {
        every { mockGeofenceApi.setInitialEnterTriggerEnabled(any()) } just Runs

        var returnedError: Throwable? = null
        command.execute(mapOf()) { _, error ->
            returnedError = error
        }

        returnedError shouldNotBe null
        returnedError?.message shouldBe "Illegal argument: 'enabled' must not be null!"
    }
}