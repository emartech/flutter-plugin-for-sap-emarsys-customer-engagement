package com.emarsys.emarsys_sdk.command.config

import android.content.SharedPreferences
import com.emarsys.Emarsys
import com.emarsys.config.ConfigApi
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.emarsys_sdk.config.ConfigStorageKeys
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test

class ChangeMerchantIdCommandTest {
    companion object {
        private const val MERCHANT_ID = "testMerchantId"
    }

    private lateinit var command: ChangeMerchantIdCommand
    private lateinit var mockConfigApi: ConfigApi
    private lateinit var mockSharedPreferences: SharedPreferences
    private lateinit var mockEdit: SharedPreferences.Editor

    @Before
    fun setUp() {
        mockkStatic(Emarsys::class)
        mockSharedPreferences = mockk(relaxed = true)
        mockConfigApi = mockk()
        mockEdit = mockk(relaxed = true)

        every { mockSharedPreferences.edit() } returns mockEdit
        every { Emarsys.config } returns mockConfigApi

        command = ChangeMerchantIdCommand(mockSharedPreferences)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }


    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenContactFieldValueIsNotPresentInParametersMap() {
        every { mockConfigApi.changeMerchantId(any()) } just Runs

        command.execute(mapOf()) { _, _ -> }

        verify(exactly = 0) { mockConfigApi.changeMerchantId(any()) }
    }

    @Test
    fun testExecute_shouldInvokeChangeMerchantIdOnEmarsys() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        every { mockConfigApi.changeMerchantId(any()) } just Runs
        every { mockEdit.putString(any(), any()) } returns mockEdit

        command.execute(mapOf("merchantId" to MERCHANT_ID), mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
        verify { mockConfigApi.changeMerchantId(MERCHANT_ID) }
        verify {
            mockEdit.putString(
                ConfigStorageKeys.PREDICT_MERCHANT_ID.name,
                MERCHANT_ID
            )
        }
        verify { mockEdit.apply() }
    }
}