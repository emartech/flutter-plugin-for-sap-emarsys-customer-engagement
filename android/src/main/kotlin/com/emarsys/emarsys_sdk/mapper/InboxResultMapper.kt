package com.emarsys.emarsys_sdk.mapper

import com.emarsys.mobileengage.api.action.*
import com.emarsys.mobileengage.api.inbox.InboxResult

class InboxResultMapper {

    fun map(inboxResult: InboxResult): List<Map<String, Any>> {
        return inboxResult.messages.map { message ->
            val resultMap = mutableMapOf<String, Any>(
                "id" to message.id,
                "campaignId" to message.campaignId,
                "title" to message.title,
                "body" to message.body,
                "receivedAt" to message.receivedAt,
            )
            actionsToMap(message.actions ?: emptyList())?.let {
                resultMap["actions"] = it
            }
            message.collapseId?.let {
                resultMap["collapseId"] = it
            }
            message.imageUrl?.let {
                resultMap["imageUrl"] = it
            }
            message.updatedAt?.let {
                resultMap["updatedAt"] = it
            }
            message.tags?.let {
                resultMap["tags"] = it
            }
            message.properties?.let {
                resultMap["properties"] = it
            }
            message.expiresAt?.let {
                resultMap["expiresAt"] = it
            }
            resultMap.toMap()
        }
    }

    private fun actionsToMap(actions: List<ActionModel>?): List<Map<String, Any?>>? {
        val actionList = actions!!.map { action ->
            val actionMap = mutableMapOf<String, Any?>(
                "id" to action.id,
                "title" to action.title,
                "type" to action.type
            )
            when (action) {
                is AppEventActionModel -> {
                    actionMap["name"] = action.name
                    actionMap["payload"] = action.payload
                }
                is CustomEventActionModel -> {
                    actionMap["name"] = action.name
                    actionMap["payload"] = action.payload
                }
                is OpenExternalUrlActionModel ->
                    actionMap["url"] = action.url.toString()
            }
            actionMap.toMap()
        }
        return if (actionList.isEmpty()) null else actionList
    }
}