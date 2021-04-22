package com.emarsys.emarsys_sdk.di

import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory

class DefaultDependencyContainer: DependencyContainer {

    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory()
    }

}