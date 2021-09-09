package com.emarsys.emarsys_sdk.flutter

import android.content.Context
import com.emarsys.emarsys_sdk.ui.InlineInAppView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class InlineInAppViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return InlineInAppView(context, viewId, creationParams,messenger)
    }
}