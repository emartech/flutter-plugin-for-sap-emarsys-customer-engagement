package com.emarsys.emarsys_sdk.command.mobileengage.push

import android.app.Application
import android.app.NotificationManager
import android.content.Context
import com.emarsys.core.util.AndroidVersionUtils
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.notification.NotificationChannelFactory

class RegisterNotificationChannelsCommand(
    private val application: Application,
    private val notificationChannelFactory: NotificationChannelFactory
) : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        if (AndroidVersionUtils.isOreoOrAbove()) {
            val manager = application.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            (parameters?.get("notificationChannels") as List<Map<String, Any>>).forEach { channelMap ->
                try {
                    manager.createNotificationChannel(
                        notificationChannelFactory.createChannel(
                            channelMap["id"] as String,
                            channelMap["name"] as String,
                            channelMap["importance"] as Int,
                            channelMap["description"] as String
                        )
                    )
                } catch (typeCastException: TypeCastException) {
                    throw IllegalArgumentException("Some parameters are missing!")
                }
            }
        }
        resultCallback(null, null)
    }
}