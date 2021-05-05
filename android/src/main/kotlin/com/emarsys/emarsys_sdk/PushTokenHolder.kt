package com.emarsys.emarsys_sdk

object PushTokenHolder {
    var pushTokenObserver : ((String?) -> Unit)? = null
    var pushToken: String? = null
        set(value) {
            field = value
            pushTokenObserver?.invoke(value)
        }
}