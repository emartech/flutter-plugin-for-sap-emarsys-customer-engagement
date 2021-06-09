package com.emarsys.emarsys_sdk

import com.emarsys.emarsys_sdk.command.ResultCallback


interface EmarsysCommand{
    fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback)
}