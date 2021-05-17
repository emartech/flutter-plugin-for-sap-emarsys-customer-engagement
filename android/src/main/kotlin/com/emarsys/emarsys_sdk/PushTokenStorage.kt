package com.emarsys.emarsys_sdk

import android.content.SharedPreferences

class PushTokenStorage(private val sharedPreferences: SharedPreferences) {
    private companion object {
        const val PUSH_TOKEN_KEY = "push_token"
    }

    var pushTokenObserver: ((String?) -> Unit)? = null
    var pushToken: String? = null
        get() = sharedPreferences.getString(PUSH_TOKEN_KEY, null)
        set(value) {
            field = value
            sharedPreferences.edit().putString(PUSH_TOKEN_KEY, value).apply()
            pushTokenObserver?.invoke(value)
        }
}