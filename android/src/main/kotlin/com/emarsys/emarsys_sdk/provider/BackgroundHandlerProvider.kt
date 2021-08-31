package com.emarsys.emarsys_sdk.provider

import android.os.Handler
import android.os.HandlerThread
import java.util.*

object BackgroundHandlerProvider {

    fun provide(): Handler {
        val handlerThread =
            HandlerThread("FlutterWrapperSDKHandlerThread-" + UUID.randomUUID().toString())
        handlerThread.start()
        return Handler(handlerThread.looper)
    }
}