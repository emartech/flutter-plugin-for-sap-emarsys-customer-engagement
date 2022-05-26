package com.emarsys.emarsys_sdk.flutter

import android.content.Context
import com.emarsys.emarsys_sdk.ui.InlineInAppView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class InlineInAppViewFactory(
    private val messenger: BinaryMessenger,
    private val applicationContext: Context
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val contextForInlineInAppView = context ?: applicationContext
        val creationParams = args as Map<String?, Any?>?
        return InlineInAppView(contextForInlineInAppView, viewId, creationParams,messenger)
    }
}