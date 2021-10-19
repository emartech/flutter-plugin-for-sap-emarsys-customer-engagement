package com.emarsys.emarsys_sdk.mapper

import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import org.json.JSONObject

class GeofenceMapper : ResultMapper<List<Geofence>> {

    override fun map(result: List<Geofence>): List<Map<String, Any>> {
        return result
                .map {
                    val resultMap = mutableMapOf(
                            "id" to it.id,
                            "lat" to it.lat,
                            "lon" to it.lon,
                            "radius" to it.radius,
                            "triggers" to mapTriggers(it.triggers)
                    )
                    it.waitInterval?.let { waitInterval ->
                        resultMap["waitInterval"] = waitInterval
                    }
                    resultMap
                }
                .toList()
    }

    private fun mapTriggers(triggers: List<Trigger>): List<Map<String, Any>> {
        return triggers
                .map {
                    mapOf(
                            "id" to it.id,
                            "type" to it.type.name,
                            "loiteringDelay" to it.loiteringDelay,
                            "action" to it.action
                    )
                }
                .toList()
    }
}