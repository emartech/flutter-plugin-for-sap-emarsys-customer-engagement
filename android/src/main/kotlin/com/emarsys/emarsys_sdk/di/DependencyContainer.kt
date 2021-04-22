package com.emarsys.emarsys_sdk.di

import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory

fun dependencyContainer() = DependencyContainer.instance
        ?: throw IllegalStateException("DependencyContainer has to be setup first!")

fun tearDownDependencyContainer() { DependencyContainer.instance = null }

fun setupDependencyContainer(container: DependencyContainer) {
    if (DependencyContainer.instance == null) {
        DependencyContainer.instance = container
    }
}

interface DependencyContainer {
    companion object {
        var instance: DependencyContainer? = null
    }

    val emarsysCommandFactory: EmarsysCommandFactory
}