package com.emarsys.emarsys_sdk.di

import android.app.Application
import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import io.mockk.mockk

class FakeDependencyContainer(override val application: Application = mockk(relaxed = true),
                              override val emarsysCommandFactory: EmarsysCommandFactory = mockk(relaxed = true)) : DependencyContainer