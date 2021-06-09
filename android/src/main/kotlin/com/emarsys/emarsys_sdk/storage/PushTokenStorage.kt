package com.emarsys.emarsys_sdk.storage

import android.content.SharedPreferences

class PushTokenStorage(private val sharedPreferences: SharedPreferences) {
    private companion object {
        const val PUSH_TOKEN_KEY = "push_token"
        const val PUSH_SENDING_ENABLED_KEY = "push_sending_enabled"
    }

    var pushTokenObserver: ((String?) -> Unit)? = null
    var enabled: Boolean = false
        get() = sharedPreferences.getBoolean(PUSH_SENDING_ENABLED_KEY, true)
        set(value) {
            field = value
            sharedPreferences.edit().putBoolean(PUSH_SENDING_ENABLED_KEY, value).apply()
        }
    var pushToken: String? = null
        get() = sharedPreferences.getString(PUSH_TOKEN_KEY, null)
        set(value) {
            field = value
            sharedPreferences.edit().putString(PUSH_TOKEN_KEY, value).apply()
            pushTokenObserver?.invoke(value)
        }
}