package com.emarsys.emarsys_sdk.command


typealias ResultCallback = (success: Any?, error: Throwable?) -> Unit

interface EmarsysCommand{
    fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback)
}