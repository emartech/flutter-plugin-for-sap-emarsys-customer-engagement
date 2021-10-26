package com.emarsys.emarsys_sdk.mapper

interface Mapper<T,E> {

    fun map(input: T): E

}