package com.emarsys.emarsys_sdk

import android.content.SharedPreferences
import io.kotlintest.shouldBe
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test


class PushTokenStorageTest {
    private companion object {
        const val PUSH_TOKEN_KEY = "push_token"
        const val PUSH_TOKEN = "testPushToken"
    }

    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var pushTokenStorage: PushTokenStorage

    @Before
    fun setUp() {
        mockSharedPreferences = mockk(relaxed = true)
        pushTokenStorage = PushTokenStorage(mockSharedPreferences)
    }

    @Test
    fun testSetPushToken_shouldSaveToCache() {
        pushTokenStorage.pushToken = PUSH_TOKEN

        verify { mockSharedPreferences.edit().putString(PUSH_TOKEN_KEY, PUSH_TOKEN).apply() }
    }

    @Test
    fun testSetPushToken_shouldGetFromCache() {
        every { mockSharedPreferences.getString(PUSH_TOKEN_KEY, null) } returns PUSH_TOKEN

        pushTokenStorage.pushToken shouldBe PUSH_TOKEN
    }

    @Test
    fun testPushTokenObserver_shouldBeTriggeredOnPushTokenSet() {
        pushTokenStorage.pushTokenObserver = { pushToken ->
            pushToken shouldBe PUSH_TOKEN
        }
        pushTokenStorage.pushToken = PUSH_TOKEN
    }
}