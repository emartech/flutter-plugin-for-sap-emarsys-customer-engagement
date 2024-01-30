package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.geofence.GeofenceApi
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
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        every { mockGeofenceApi.disable() } just Runs

        command.execute(mapOf(), mockResultCallback)

        verify { mockGeofenceApi.disable() }
        verify { mockResultCallback.invoke(null, null) }
    }
}