package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.EmarsysCommand
import com.emarsys.emarsys_sdk.commands.push.ClearPushTokenCommand


class EmarsysCommandFactory{

    fun create(methodName: String): EmarsysCommand? {
        return when(methodName) {
                "setup" -> SetupCommand()
                "setContact" -> SetContactCommand()
                "clearContact" -> ClearContactCommand()
                "push.clearPushToken" -> ClearPushTokenCommand()
            else -> null
        }
    }
}