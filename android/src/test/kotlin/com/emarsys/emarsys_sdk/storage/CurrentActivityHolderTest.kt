package com.emarsys.emarsys_sdk.storage

import android.app.Activity
import io.kotest.matchers.shouldBe
import io.mockk.mockk
import org.junit.Before
import org.junit.Test
import java.lang.ref.WeakReference

internal class CurrentActivityHolderTest {
    private lateinit var mockActivity: Activity
    private lateinit var currentActivityHolder: CurrentActivityHolder

    @Before
    fun setUp() {
        mockActivity = mockk(relaxed = true)
        currentActivityHolder = CurrentActivityHolder()
    }

    @Test
    fun testCurrentActivityObserver_shouldBeTriggeredOnPushTokenSet() {

        currentActivityHolder.currentActivityObserver = { it?.get() shouldBe mockActivity }
        currentActivityHolder.currentActivity = WeakReference(mockActivity)
    }
}