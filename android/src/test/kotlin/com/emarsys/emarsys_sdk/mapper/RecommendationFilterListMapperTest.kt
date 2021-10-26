package com.emarsys.emarsys_sdk.mapper

import com.emarsys.Emarsys
import io.kotlintest.shouldBe
import org.junit.Assert.*

import org.junit.Before
import org.junit.Test

class RecommendationFilterListMapperTest {
    private lateinit var mapper: RecommendationFilterListMapper

    @Before
    fun setUp() {
        mapper = RecommendationFilterListMapper()
    }

    @Test
    fun test_mapShouldReturnEmptyList_whenMapIsEmpty() {
        val result = mapper.map(emptyList())

        result shouldBe listOf()
    }

    @Test
    fun test_mapShouldMapIncludeCorrectly() {
        val testMap1 = mapOf("filterType" to "INCLUDE", "field" to "testField1", "comparison" to "IS", "values" to listOf("value1"))
        val testMap2 = mapOf("filterType" to "INCLUDE", "field" to "testField2", "comparison" to "HAS", "values" to listOf("value2"))
        val testMap3 = mapOf("filterType" to "INCLUDE", "field" to "testField3", "comparison" to "IN", "values" to listOf("value3", "value4"))
        val testMap4 = mapOf("filterType" to "INCLUDE", "field" to "testField4", "comparison" to "OVERLAPS", "values" to listOf("value5", "value6"))

        val result = mapper.map(listOf(testMap1, testMap2, testMap3, testMap4))

        result[0].type shouldBe "INCLUDE"
        result[0].field shouldBe "testField1"
        result[0].comparison shouldBe "IS"
        result[0].expectations shouldBe listOf("value1")
        result[1].type shouldBe "INCLUDE"
        result[1].field shouldBe "testField2"
        result[1].comparison shouldBe "HAS"
        result[1].expectations shouldBe listOf("value2")
        result[2].type shouldBe "INCLUDE"
        result[2].field shouldBe "testField3"
        result[2].comparison shouldBe "IN"
        result[2].expectations shouldBe listOf("value3", "value4")
        result[3].type shouldBe "INCLUDE"
        result[3].field shouldBe "testField4"
        result[3].comparison shouldBe "OVERLAPS"
        result[3].expectations shouldBe listOf("value5", "value6")
    }

    @Test
    fun test_mapShouldMapExcludeCorrectly() {
        val testMap1 = mapOf("filterType" to "EXCLUDE", "field" to "testField1", "comparison" to "IS", "values" to listOf("value1"))
        val testMap2 = mapOf("filterType" to "EXCLUDE", "field" to "testField2", "comparison" to "HAS", "values" to listOf("value2"))
        val testMap3 = mapOf("filterType" to "EXCLUDE", "field" to "testField3", "comparison" to "IN", "values" to listOf("value3", "value4"))
        val testMap4 = mapOf("filterType" to "EXCLUDE", "field" to "testField4", "comparison" to "OVERLAPS", "values" to listOf("value5", "value6"))

        val result = mapper.map(listOf(testMap1, testMap2, testMap3, testMap4))

        result[0].type shouldBe "EXCLUDE"
        result[0].field shouldBe "testField1"
        result[0].comparison shouldBe "IS"
        result[0].expectations shouldBe listOf("value1")
        result[1].type shouldBe "EXCLUDE"
        result[1].field shouldBe "testField2"
        result[1].comparison shouldBe "HAS"
        result[1].expectations shouldBe listOf("value2")
        result[2].type shouldBe "EXCLUDE"
        result[2].field shouldBe "testField3"
        result[2].comparison shouldBe "IN"
        result[2].expectations shouldBe listOf("value3", "value4")
        result[3].type shouldBe "EXCLUDE"
        result[3].field shouldBe "testField4"
        result[3].comparison shouldBe "OVERLAPS"
        result[3].expectations shouldBe listOf("value5", "value6")
    }
}