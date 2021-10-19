package com.emarsys.emarsys_sdk.mapper

interface ResultMapper<T> {

    fun map(result: T): List<Map<String, Any>>

}