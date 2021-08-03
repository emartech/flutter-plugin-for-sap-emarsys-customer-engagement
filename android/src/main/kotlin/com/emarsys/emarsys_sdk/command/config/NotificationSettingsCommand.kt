package com.emarsys.emarsys_sdk.command.config

import com.emarsys.Emarsys
import com.emarsys.core.api.notification.NotificationSettings
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class NotificationSettingsCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        resultCallback.invoke(Emarsys.config.notificationSettings.toNotificationSettingsMap(), null)
    }

    private fun NotificationSettings.toNotificationSettingsMap(): Map<String, Any> {
        val result = mutableMapOf<String, Any>()
        result["areNotificationsEnabled"] = this.areNotificationsEnabled
        result["importance"] = this.importance
        result["channelSettings"] = this.channelSettings.map {
            mapOf(
                "channelId" to it.channelId,
                "importance" to it.importance,
                "isCanBypassDnd" to it.isCanBypassDnd,
                "isCanShowBadge" to it.isCanShowBadge,
                "isShouldVibrate" to it.isShouldVibrate,
                "isShouldShowLights" to it.isShouldShowLights
            )
        }

        return mapOf<String, Any>("android" to result.toMap())
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        return true
    }

    override fun hashCode(): Int {
        return javaClass.hashCode()
    }
}