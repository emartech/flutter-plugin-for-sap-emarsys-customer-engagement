package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.geofence.GeofenceApi
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class GeofenceEnableCommandTest {
    private lateinit var command: GeofenceEnableCommand
    private lateinit var mockGeofenceApi: GeofenceApi

    @Before
    fun setUp() {
        mockGeofenceApi = mockk()
        mockkStatic(Emarsys::class)
        every { Emarsys.geofence } returns mockGeofenceApi
        command = GeofenceEnableCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldDelegateCallToEmarsys() {
        every { mockGeofenceApi.enable() } just Runs

        command.execute(mapOf()) { _, _ ->  }

        verify { mockGeofenceApi.enable() }
    }
}