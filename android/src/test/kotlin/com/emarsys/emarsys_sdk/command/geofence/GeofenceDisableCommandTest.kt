package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.geofence.GeofenceApi
import com.emarsys.mobileengage.geofence.GeofenceInternal
import io.mockk.*
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

class GeofenceDisableCommandTest {
    private lateinit var command: GeofenceDisableCommand
    private lateinit var mockGeofenceApi: GeofenceApi

    @Before
    fun setUp() {
        mockGeofenceApi = mockk()
        mockkStatic(Emarsys::class)
        every { Emarsys.geofence } returns mockGeofenceApi
        command = GeofenceDisableCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldCallMethodOnEmarsys() {
        every { mockGeofenceApi.disable() } just Runs

        command.execute(mapOf()) { _, _ ->  }

        verify { mockGeofenceApi.disable() }
    }
}