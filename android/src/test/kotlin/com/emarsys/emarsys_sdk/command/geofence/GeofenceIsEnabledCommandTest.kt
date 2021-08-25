package com.emarsys.emarsys_sdk.command.geofence

import com.emarsys.Emarsys
import com.emarsys.geofence.GeofenceApi
import io.kotlintest.shouldBe
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class GeofenceIsEnabledCommandTest {
    private lateinit var command: GeofenceIsEnabledCommand
    private lateinit var mockGeofenceApi: GeofenceApi

    @Before
    fun setUp() {
        mockGeofenceApi = mockk()
        mockkStatic(Emarsys::class)
        every { Emarsys.geofence } returns mockGeofenceApi
        command = GeofenceIsEnabledCommand()
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }

    @Test
    fun testExecute_shouldDelegateCallToEmarsys() {
        every { mockGeofenceApi.isEnabled() } returns true

        var returnedResult: Boolean? = null
        command.execute(mapOf()) { result, _ ->
            returnedResult = result as? Boolean
        }

        verify { mockGeofenceApi.isEnabled() }
        returnedResult shouldBe true
    }
}