package com.emarsys.emarsys_sdk.mapper

import com.emarsys.mobileengage.api.action.*
import com.emarsys.mobileengage.api.inbox.InboxResult
import com.emarsys.mobileengage.api.inbox.Message
import io.kotlintest.shouldBe
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import java.net.URL

class InboxResultMapperTest {

    private lateinit var mapper: InboxResultMapper

    @Before
    fun setUp() {
        mapper = InboxResultMapper()
    }

    @Test
    fun test_mapShouldReturnWithEmptyList() {
        val result = mapper.map(InboxResult(emptyList()))

        result shouldBe emptyList()
    }

    @Test
    fun test_mapShouldMapMessages() {
        val message1 = Message(
            "testId",
            "testCampaignId",
            "testCollapseId",
            "testTitle",
            "testBody",
            "testImageUrl",
            1234,
            4321,
            5678,
            listOf("TAG1", "TAG2", "TAG3"),
            mapOf("key1" to "value1", "key2" to "value2"),
            listOf(
                AppEventActionModel(
                    "actionId1",
                    "actionTitle1",
                    "MEAppEvent",
                    "actionName1",
                    mapOf("key11" to "value", "key12" to 123)
                ),
                CustomEventActionModel(
                    "actionId2",
                    "actionTitle2",
                    "MECustomEvent",
                    "actionName2",
                    mapOf("key21" to "value", "key22" to 456)
                ),
                OpenExternalUrlActionModel(
                    "actionId4",
                    "actionTitle4",
                    "OpenExternalUrl",
                    URL("https://www.emarsys.com")
                )
            )
        )
        val message2 = Message(
            "testId2",
            "testCampaignId2",
            "testCollapseId2",
            "testTitle2",
            "testBody2",
            "testImageUrl2",
            1234,
            4321,
            5678,
            listOf("TAG1", "TAG2", "TAG3"),
            mapOf("key1" to "value1", "key2" to "value2"),
            null
        )

        val expectedResult: List<Map<String, Any>> = listOf(
            mapOf(
                "id" to "testId",
                "campaignId" to "testCampaignId",
                "collapseId" to "testCollapseId",
                "title" to "testTitle",
                "body" to "testBody",
                "imageUrl" to "testImageUrl",
                "receivedAt" to 1234,
                "updatedAt" to 4321,
                "expiresAt" to 5678,
                "tags" to listOf("TAG1", "TAG2", "TAG3"),
                "properties" to mapOf("key1" to "value1", "key2" to "value2"),
                "actions" to listOf(
                    mapOf(
                        "id" to "actionId1",
                        "title" to "actionTitle1",
                        "type" to "MEAppEvent",
                        "name" to "actionName1",
                        "payload" to mapOf("key11" to "value", "key12" to 123)
                    ),
                    mapOf(
                        "id" to "actionId2",
                        "title" to "actionTitle2",
                        "type" to "MECustomEvent",
                        "name" to "actionName2",
                        "payload" to mapOf("key21" to "value", "key22" to 456)
                    ),
                    mapOf(
                        "id" to "actionId4",
                        "title" to "actionTitle4",
                        "type" to "OpenExternalUrl",
                        "url" to "https://www.emarsys.com"
                    )
                )
            ),
            mapOf(
                "id" to "testId2",
                "campaignId" to "testCampaignId2",
                "collapseId" to "testCollapseId2",
                "title" to "testTitle2",
                "body" to "testBody2",
                "imageUrl" to "testImageUrl2",
                "receivedAt" to 1234,
                "updatedAt" to 4321,
                "expiresAt" to 5678,
                "tags" to listOf("TAG1", "TAG2", "TAG3"),
                "properties" to mapOf("key1" to "value1", "key2" to "value2")
            )
        )
        val result = mapper.map(InboxResult(listOf(message1, message2)))

        result[0].entries.forEach {
            expectedResult[0][it.key] shouldBe it.value
        }
        expectedResult[0].entries.forEach {
            result[0][it.key] shouldBe it.value
        }
        result[1].entries.forEach {
            expectedResult[1][it.key] shouldBe it.value
        }
        expectedResult[1].entries.forEach {
            result[1][it.key] shouldBe it.value
        }
    }
}