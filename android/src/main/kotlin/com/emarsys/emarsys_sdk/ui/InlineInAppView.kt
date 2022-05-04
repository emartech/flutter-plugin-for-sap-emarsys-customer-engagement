package com.emarsys.emarsys_sdk.ui

import android.content.Context
import android.view.View
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.core.util.JsonUtils
import com.emarsys.mobileengage.iam.jsbridge.OnAppEventListener
import com.emarsys.mobileengage.iam.jsbridge.OnCloseListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import com.emarsys.inapp.ui.InlineInAppView as NativeInlineInAppView
import io.flutter.plugin.platform.PlatformView
import org.json.JSONObject

class InlineInAppView(
    context: Context,
    id: Int,
    creationParams: Map<String?, Any?>?,
    messenger: BinaryMessenger
) :
    PlatformView {
    val view: NativeInlineInAppView
    override fun getView(): View {
        return view
    }

    override fun dispose() {

    }

    init {
        val onCloseHandler = createOnCloseEventChannel()
        EventChannel(
            messenger,
            "inlineInAppViewOnClose$id"
        ).setStreamHandler(onCloseHandler as EventChannel.StreamHandler)
        val onCompletedHandler = createOnCompletedChannel()
        EventChannel(
            messenger,
            "inlineInAppViewOnCompleted$id"
        ).setStreamHandler(onCompletedHandler as EventChannel.StreamHandler)
        val onAppEventHandler = createOnAppEventChannel()
        EventChannel(
            messenger,
            "inlineInAppViewOnAppEvent$id"
        ).setStreamHandler(onAppEventHandler as EventChannel.StreamHandler)
        view = NativeInlineInAppView(context)
        view.onCloseListener = onCloseHandler
        view.onCompletionListener = onCompletedHandler
        view.onAppEventListener = onAppEventHandler
        view.loadInApp(creationParams?.get("viewId") as String)
    }

    private fun createOnCloseEventChannel(): OnCloseListener {
        val onCloseHandler = object : EventChannel.StreamHandler, OnCloseListener {
            var events: EventChannel.EventSink? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this.events = events
            }

            override fun onCancel(arguments: Any?) {
                events = null
            }

            override fun invoke() {
                events?.success(mapOf<String, String>())
            }
        }
        return onCloseHandler
    }

    private fun createOnCompletedChannel(): CompletionListener {
        val onCompletedHandler = object : EventChannel.StreamHandler, CompletionListener {
            var events: EventChannel.EventSink? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this.events = events
            }

            override fun onCancel(arguments: Any?) {
                events = null
            }

            override fun onCompleted(errorCause: Throwable?) {
                if (errorCause != null) {
                    events?.error("500", errorCause.message, errorCause)
                } else {
                    events?.success(mapOf<String, Any>())
                }
            }
        }
        return onCompletedHandler
    }

    private fun createOnAppEventChannel(): OnAppEventListener {
        val onAppEventHandler = object : EventChannel.StreamHandler, OnAppEventListener {
            var events: EventChannel.EventSink? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this.events = events
            }

            override fun onCancel(arguments: Any?) {
                events = null
            }

            override fun invoke(property: String?, json: JSONObject) {
                events?.success(
                    mapOf(
                        "name" to property,
                        "payload" to JsonUtils.toMap(json)
                    )
                )
            }
        }
        return onAppEventHandler
    }
}