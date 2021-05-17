package com.emarsys.emarsys_sdk_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.app.FlutterApplication


class ExampleApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate();

        createNotificationChannels()
    }


    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= 26) {
            createNotificationChannel(
                "ems_sample_news",
                "News",
                "News and updates go into this channel",
                NotificationManager.IMPORTANCE_HIGH
            )
            createNotificationChannel(
                "ems_sample_messages",
                "Messages",
                "Important messages go into this channel",
                NotificationManager.IMPORTANCE_HIGH
            )
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private fun createNotificationChannel(id: String, name: String, description: String, importance: Int) {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val channel = NotificationChannel(id, name, importance)
        channel.description = description
        notificationManager.createNotificationChannel(channel)
    }

}