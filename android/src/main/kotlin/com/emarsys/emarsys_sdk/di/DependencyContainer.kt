package com.emarsys.emarsys_sdk.di

import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory

fun dependencyContainer() = DependencyContainer.instance ?: throw IllegalStateException("DependencyContainer has to be setup first!")

interface DependencyContainer {
    companion object {
        var instance: DependencyContainer? = null
    }

    val emarsysCommandFactory: EmarsysCommandFactory
}