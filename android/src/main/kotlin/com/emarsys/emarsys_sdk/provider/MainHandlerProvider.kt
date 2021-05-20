package com.emarsys.emarsys_sdk.provider

import android.os.Handler
import android.os.Looper

object MainHandlerProvider {

    fun provide(): Handler {
        return Handler(Looper.getMainLooper())
    }
}