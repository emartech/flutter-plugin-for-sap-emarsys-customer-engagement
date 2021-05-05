package com.emarsys.emarsys_sdk

import com.emarsys.service.EmarsysMessagingServiceUtils
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class EmarsysMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        EmarsysMessagingServiceUtils.handleMessage(this, message)
    }

    override fun onNewToken(pushToken: String) {
        super.onNewToken(pushToken)
        PushTokenHolder.pushToken = pushToken
    }
}