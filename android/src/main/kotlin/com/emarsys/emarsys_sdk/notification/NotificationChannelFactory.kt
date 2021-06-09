package com.emarsys.emarsys_sdk.notification

import android.app.NotificationChannel
import android.os.Build
import androidx.annotation.RequiresApi

class NotificationChannelFactory {
    @RequiresApi(Build.VERSION_CODES.O)
    fun createChannel(id: String, name: String, importance: Int, description: String): NotificationChannel {
        val result = NotificationChannel(id, name, importance)
        result.description = description
        return result
    }
}