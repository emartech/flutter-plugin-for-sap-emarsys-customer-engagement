package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback

class TrackCategoryViewCommand : EmarsysCommand {

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val categoryPath: String? = parameters?.get("categoryPath") as String?
        categoryPath ?: throw IllegalArgumentException("categoryPath should not be null!")

        Emarsys.predict.trackCategoryView(categoryPath)

        resultCallback.invoke(null, null)
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