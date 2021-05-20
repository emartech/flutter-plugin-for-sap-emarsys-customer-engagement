package com.emarsys.emarsys_sdk

import android.content.Context
import com.emarsys.mobileengage.api.event.EventHandler
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import org.json.JSONObject

class EventHandlerFactory(private val binaryMessenger: BinaryMessenger) {


    private var eventChannels: Map<EventChannelName, EventChannel>

    enum class EventChannelName(val channelName: String) {
        PUSH("com.emarsys.events.push"),
        SILENT_PUSH("com.emarsys.events.silentPush")
    }

    init {
        eventChannels = EventChannelName.values()
            .associate { Pair(it, EventChannel(binaryMessenger, it.channelName)) }
    }

    fun create(eventChannelName: EventChannelName): EventHandler {
        return object : EventHandler {
            val eventChannel: EventChannel = eventChannels[eventChannelName]!!
            override fun handleEvent(context: Context, eventName: String, payload: JSONObject?) {
                eventChannel.setStreamHandler(
                    object : EventChannel.StreamHandler {

                        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                            events?.success(
                                mapOf(
                                    "name" to eventName,
                                    "payload" to payload
                                )
                            )
                        }
                        override fun onCancel(arguments: Any?) {

                        }
                    })
            }

        }
    }

}
