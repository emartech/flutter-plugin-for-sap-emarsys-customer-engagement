package com.emarsys.emarsys_sdk.storage

import android.app.Activity
import java.lang.ref.WeakReference

class CurrentActivityHolder {
    var currentActivityObserver: ((WeakReference<Activity?>?) -> Unit)? = null
    var currentActivity: WeakReference<Activity?>? = null
        set(value) {
            field = value
            currentActivityObserver?.invoke(value)
        }
}