package com.emarsys.emarsys_sdk.commands

import com.emarsys.emarsys_sdk.EmarsysCommand


class EmarsysCommandFactory{

    fun create(methodName: String): EmarsysCommand? {
        return when(methodName) {
                "setup" -> SetupCommand()
                "setContact" -> SetContactCommand()
                "clearContact" -> ClearContactCommand()
            else -> null
        }
    }
}