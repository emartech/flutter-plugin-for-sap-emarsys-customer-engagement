package com.emarsys.emarsys_sdk.mapper

import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import com.emarsys.mobileengage.api.geofence.TriggerType
import io.kotest.matchers.shouldBe
import org.json.JSONObject
import org.junit.Before
import org.junit.Test

class GeofenceMapperTest {

    private lateinit var mapper: GeofenceMapper

    @Before
    fun setUp() {
        mapper = GeofenceMapper()
    }

    @Test
    fun test_mapShouldReturnWithEmptyList() {
        val result = mapper.map(emptyList())

        result shouldBe emptyList()
    }

    @Test
    fun test_mapShouldMap() {
        val actionMap = mapOf(
            "id" to "testId",
            "type" to "MECustomEvent",
            "name" to "testName",
            "payload" to mapOf("key" to "value")
        )
        val actionJson = JSONObject(
            actionMap
        )
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
                    actionJson
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
                    JSONObject()
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
                        "action" to actionMap
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
                        "loiteringDelay" to 456
                    )
                )
            )
        )

        val result = mapper.map(listOf(geofence1, geofence2))

        result[0].entries.forEach {
            it.value shouldBe expectedResult[0][it.key]
        }
        expectedResult[0].entries.forEach {
            it.value shouldBe result[0][it.key]
        }
        result[1].entries.forEach {
            it.value shouldBe expectedResult[1][it.key]
        }
        expectedResult[1].entries.forEach {
            it.value shouldBe result[1][it.key]
        }
    }

}