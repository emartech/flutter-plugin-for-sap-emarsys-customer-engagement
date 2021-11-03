package com.emarsys.emarsys_sdk.mapper

import com.emarsys.emarsys_sdk.util.JsonUtils
import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import org.json.JSONObject

class GeofenceMapper : Mapper<List<Geofence>, List<Map<String, Any>>> {

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
                resultMap.toMap()
            }
    }

    private fun mapTriggers(triggers: List<Trigger>): List<Map<String, Any>> {
        return triggers
            .map {
                val mappedAction = mutableMapOf<String, Any>(
                    "id" to it.id,
                    "type" to it.type.name,
                    "loiteringDelay" to it.loiteringDelay,
                )
                mapAction(it.action)?.let { action ->
                    mappedAction["action"] = action
                }
                mappedAction
            }
            .toList()
    }

    private fun mapAction(action: JSONObject): Map<String, Any>? {
        if (action.length() != 0) {
            val result = mutableMapOf(
                "id" to action.get("id"),
                "type" to action.get("type")
            )

            when (action["type"]) {
                "OpenExternalUrl" -> result["url"] = action.get("url")
                "MECustomEvent", "MEAppEvent" -> {
                    result["name"] = action.get("name")
                    result["payload"] = JsonUtils.toMap(action.get("payload") as JSONObject)
                }
            }
            return result.toMap()
        }
        return null
    }
}