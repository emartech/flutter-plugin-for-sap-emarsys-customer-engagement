package com.emarsys.emarsys_sdk.mapper

import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import com.emarsys.mobileengage.api.geofence.TriggerType
import io.kotlintest.shouldBe
import io.mockk.mockk
import org.json.JSONObject
import org.junit.Before
import org.junit.Test

class GeofenceMapperTest {

    private lateinit var mapper: GeofenceMapper
    private lateinit var mockJson: JSONObject

    @Before
    fun setUp() {
        mapper = GeofenceMapper()
        mockJson = mockk()
    }

    @Test
    fun test_mapShouldReturnWithEmptyList() {
        val result = mapper.map(emptyList())

        result shouldBe emptyList()
    }

    @Test
    fun test_mapShouldMap() {
        val geofence1 = Geofence(
                "testGeofenceId",
                12.34,
                56.78,
                30.0,
                90.12,
                listOf(
                        Trigger(
                                "testTriggerId",
                                TriggerType.ENTER,
                                123,
                                mockJson
                        )
                )
        )
        val geofence2 = Geofence(
                "testGeofenceId2",
                12.34,
                56.78,
                30.0,
                90.12,
                listOf(
                        Trigger(
                                "testTriggerId2",
                                TriggerType.EXIT,
                                456,
                                mockJson
                        )
                )
        )

        val expectedResult = listOf(
                mapOf(
                        "id" to "testGeofenceId",
                        "lat" to 12.34,
                        "lon" to 56.78,
                        "radius" to 30.0,
                        "waitInterval" to 90.12,
                        "triggers" to listOf(
                                mapOf(
                                        "id" to "testTriggerId",
                                        "type" to "ENTER",
                                        "loiteringDelay" to 123,
                                        "action" to mockJson
                                )
                        )
                ),
                mapOf(
                        "id" to "testGeofenceId2",
                        "lat" to 12.34,
                        "lon" to 56.78,
                        "radius" to 30.0,
                        "waitInterval" to 90.12,
                        "triggers" to listOf(
                                mapOf(
                                        "id" to "testTriggerId2",
                                        "type" to "EXIT",
                                        "loiteringDelay" to 456,
                                        "action" to mockJson
                                )
                        )
                )
        )

        val result = mapper.map(listOf(geofence1, geofence2))

        result[0].entries.forEach {
            expectedResult[0][it.key] shouldBe it.value
        }
        expectedResult[0].entries.forEach {
            result[0][it.key] shouldBe it.value
        }
        result[1].entries.forEach {
            expectedResult[1][it.key] shouldBe it.value
        }
        expectedResult[1].entries.forEach {
            result[1][it.key] shouldBe it.value
        }
    }

}