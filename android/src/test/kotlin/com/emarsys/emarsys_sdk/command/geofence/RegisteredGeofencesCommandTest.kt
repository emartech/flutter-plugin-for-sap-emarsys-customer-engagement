package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.mapper.GeofenceMapper
import com.emarsys.geofence.GeofenceApi
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
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
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        val resultMap = listOf<Map<String, Any>>()

        every { mockGeofenceMapper.map(any()) } returns resultMap
        every { mockGeofenceApi.registeredGeofences } returns listOf()

        command.execute(mapOf(), mockResultCallback)

        verify { mockGeofenceApi.registeredGeofences }
        verify { mockResultCallback.invoke(resultMap, null) }
    }
}