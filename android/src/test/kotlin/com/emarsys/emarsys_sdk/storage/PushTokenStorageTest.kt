package com.emarsys.emarsys_sdk.storage

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
        const val PUSH_SENDING_ENABLED_KEY = "push_sending_enabled"
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
    fun testGetPushToken_shouldGetFromCache() {
        every { mockSharedPreferences.getString(PUSH_TOKEN_KEY, null) } returns PUSH_TOKEN

        pushTokenStorage.pushToken shouldBe PUSH_TOKEN
    }

    @Test
    fun testSetEnabled_shouldSaveToCache() {
        pushTokenStorage.enabled = false

        verify { mockSharedPreferences.edit().putBoolean(PUSH_SENDING_ENABLED_KEY, false).apply() }
    }

    @Test
    fun testGetEnabled_shouldGetFromCache() {
        every { mockSharedPreferences.getBoolean(PUSH_SENDING_ENABLED_KEY, any()) } returns true

        pushTokenStorage.enabled shouldBe true
    }

    @Test
    fun testPushTokenObserver_shouldBeTriggeredOnPushTokenSet() {
        pushTokenStorage.pushTokenObserver = { pushToken ->
            pushToken shouldBe PUSH_TOKEN
        }
        pushTokenStorage.pushToken = PUSH_TOKEN
    }
}