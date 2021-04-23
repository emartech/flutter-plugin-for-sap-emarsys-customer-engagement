package com.emarsys.emarsys_sdk.di

import android.app.Application
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory

class DefaultDependencyContainer(override val application: Application) : DependencyContainer {

    override val emarsysCommandFactory: EmarsysCommandFactory by lazy {
        EmarsysCommandFactory()
    }

}