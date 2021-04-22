package com.emarsys.emarsys_sdk

import com.emarsys.emarsys_sdk.callbacks.ResultCallback

interface EmarsysCommand{
    fun execute(parameters: Map<String, Any>, resultCallback: ResultCallback)
}