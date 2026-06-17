package com.emarsys.emarsys_sdk.flutter

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.kotest.matchers.shouldBe
import io.mockk.mockk
import org.junit.Before
import org.junit.Test

class InlineInAppViewFactoryTest {

    private companion object {
        const val FIRST_PLATFORM_VIEW_ID = 0
        const val SECOND_PLATFORM_VIEW_ID = 1
    }

    private lateinit var mockApplicationContext: Context
    private lateinit var mockInitialMessenger: BinaryMessenger
    private lateinit var mockReattachedMessenger: BinaryMessenger
    private lateinit var resolvedMessengersAtCreation: MutableList<BinaryMessenger>
    private var currentMessenger: BinaryMessenger? = null
    private lateinit var inlineInAppViewFactory: InlineInAppViewFactory

    @Before
    fun setUp() {
        mockApplicationContext = mockk(relaxed = true)
        mockInitialMessenger = mockk(relaxed = true)
        mockReattachedMessenger = mockk(relaxed = true)
        resolvedMessengersAtCreation = mutableListOf()
        currentMessenger = mockInitialMessenger

        inlineInAppViewFactory = InlineInAppViewFactory(
            currentMessengerProvider = {
                val resolvedMessenger = currentMessenger!!
                resolvedMessengersAtCreation.add(resolvedMessenger)
                resolvedMessenger
            },
            applicationContext = mockApplicationContext
        )
    }

    @Test
    fun create_shouldQueryMessengerProviderAtCreationTime() {
        runCatching {
            inlineInAppViewFactory.create(null, FIRST_PLATFORM_VIEW_ID, emptyMap<String?, Any?>())
        }

        resolvedMessengersAtCreation.size shouldBe 1
        resolvedMessengersAtCreation[0] shouldBe mockInitialMessenger
    }

    @Test
    fun create_shouldUseUpdatedMessenger_whenEngineReattachesBetweenCreations() {
        runCatching {
            inlineInAppViewFactory.create(null, FIRST_PLATFORM_VIEW_ID, emptyMap<String?, Any?>())
        }

        currentMessenger = mockReattachedMessenger

        runCatching {
            inlineInAppViewFactory.create(null, SECOND_PLATFORM_VIEW_ID, emptyMap<String?, Any?>())
        }

        resolvedMessengersAtCreation.size shouldBe 2
        resolvedMessengersAtCreation[0] shouldBe mockInitialMessenger
        resolvedMessengersAtCreation[1] shouldBe mockReattachedMessenger
    }

    @Test
    fun create_shouldNotCacheMessengerAtFactoryConstruction() {
        currentMessenger = mockReattachedMessenger

        runCatching {
            inlineInAppViewFactory.create(null, FIRST_PLATFORM_VIEW_ID, emptyMap<String?, Any?>())
        }

        resolvedMessengersAtCreation.size shouldBe 1
        resolvedMessengersAtCreation[0] shouldBe mockReattachedMessenger
    }
}
