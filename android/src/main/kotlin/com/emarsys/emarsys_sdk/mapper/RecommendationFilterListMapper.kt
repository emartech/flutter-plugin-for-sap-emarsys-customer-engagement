package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.RecommendationFilter

class RecommendationFilterListMapper : Mapper<List<Map<String, Any?>>, List<RecommendationFilter>> {
    override fun map(input: List<Map<String, Any?>>): List<RecommendationFilter> {
        return input.map { filterMap ->
            mapRecommendationFilter(filterMap)
        }.filterNotNull()
    }

    private fun mapRecommendationFilter(input: Map<String, Any?>): RecommendationFilter? {
        val expectations = input["values"] as List<String>
        if (input["filterType"] == "INCLUDE") {
            val filter = RecommendationFilter.include(input["field"] as String)
            return when (input["comparison"]) {
                "IS" -> filter.isValue(expectations[0])
                "HAS" -> filter.hasValue(expectations[0])
                "IN" -> filter.inValues(expectations)
                "OVERLAPS" -> filter.overlapsValues(expectations)
                else -> null
            }
        } else if (input["filterType"] == "EXCLUDE") {
            val filter = RecommendationFilter.exclude(input["field"] as String)
            return when (input["comparison"]) {
                "IS" -> filter.isValue(expectations[0])
                "HAS" -> filter.hasValue(expectations[0])
                "IN" -> filter.inValues(expectations)
                "OVERLAPS" -> filter.overlapsValues(expectations)
                else -> null
            }
        } else {
            return null
        }
    }
}