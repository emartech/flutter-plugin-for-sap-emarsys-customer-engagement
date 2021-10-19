package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.mapper.GeofenceMapper
import com.emarsys.geofence.GeofenceApi
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test


internal class RegisteredGeofencesCommandTest {
    private lateinit var command: RegisteredGeofencesCommand
    private lateinit var mockGeofenceApi: GeofenceApi
    private lateinit var mockGeofenceMapper: GeofenceMapper

    @Before
    fun setUp() {
        mockGeofenceApi = mockk()
        mockkStatic(Emarsys::class)
        every { Emarsys.geofence } returns mockGeofenceApi
        mockGeofenceMapper = mockk()
        every { mockGeofenceMapper.map(any()) } returns listOf()
        command = RegisteredGeofencesCommand(mockGeofenceMapper)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldDelegateCallToEmarsys() {
        every { mockGeofenceApi.registeredGeofences } returns listOf()

        command.execute(mapOf()) { _, _ -> }

        verify { mockGeofenceApi.registeredGeofences }
    }
}