package com.emarsys.emarsys_sdk.event

import android.content.Context
import com.emarsys.core.util.JsonUtils
import com.emarsys.mobileengage.api.event.EventHandler
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import org.json.JSONObject

class EventHandlerFactory(private val binaryMessenger: BinaryMessenger) {

    private var eventChannels: Map<EventChannelName, EventChannel>

    enum class EventChannelName(val channelName: String) {
        PUSH("com.emarsys.events.push"),
        SILENT_PUSH("com.emarsys.events.silentPush"),
        GEOFENCE("com.emarsys.events.geofence"),
        INAPP("com.emarsys.events.inApp")
    }

    init {
        eventChannels = EventChannelName.values()
            .associate { Pair(it, EventChannel(binaryMessenger, it.channelName)) }
    }

    fun create(eventChannelName: EventChannelName): EventHandler {
        val handler = object : EventChannel.StreamHandler, EventHandler {

            var events: EventChannel.EventSink? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this.events = events
            }

            override fun onCancel(arguments: Any?) {
            }

            override fun handleEvent(context: Context, eventName: String, payload: JSONObject?) {
                events?.success(mapOf(
                                    "name" to eventName,
                                    "payload" to JsonUtils.toMap(payload ?: JSONObject())
                                ))
            }
        }
        val eventChannel: EventChannel = eventChannels[eventChannelName]!!
        eventChannel.setStreamHandler(handler)
        return handler
    }
}
