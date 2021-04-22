package com.emarsys.emarsys_sdk.di

object DependencyInjection {

    fun setup(container: DependencyContainer) {
        if (DependencyContainer.instance == null) {
            DependencyContainer.instance = container
        }
    }
}