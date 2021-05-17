package com.emarsys.emarsys_sdk.commands.config

import com.emarsys.Emarsys
import com.emarsys.core.api.notification.NotificationSettings
import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.commands.ResultCallback

class PushSettingsCommand : EmarsysCommand {
    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        resultCallback.invoke(Emarsys.config.notificationSettings.toPushSettingsMap(), null)
    }

    private fun NotificationSettings.toPushSettingsMap(): Map<String, Any> {
        val result = mutableMapOf<String, Any>()
        result["areNotificationsEnabled"] = this.areNotificationsEnabled()
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

        return result.toMap()
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