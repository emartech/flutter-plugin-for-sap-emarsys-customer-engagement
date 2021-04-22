package com.emarsys.emarsys_sdk.di

import com.emarsys.emarsys_sdk.commands.EmarsysCommandFactory
import io.mockk.mockk

class FakeDependencyContainer(override val emarsysCommandFactory: EmarsysCommandFactory = mockk(relaxed = true)) : DependencyContainer