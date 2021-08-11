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

class ChangeApplicationCodeCommandTest {
    companion object {
        private const val APP_CODE = "testApplicationCode"
    }

    private lateinit var command: ChangeApplicationCodeCommand
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

        command = ChangeApplicationCodeCommand(mockSharedPreferences)
    }

    @After
    fun tearDown() {
        unmockkStatic(Emarsys::class)
    }


    @Test(expected = IllegalArgumentException::class)
    fun testExecute_shouldThrowException_whenContactFieldValueIsNotPresentInParametersMap() {
        every { mockConfigApi.changeApplicationCode(any()) } just Runs

        command.execute(mapOf()) { _, _ -> }

        verify(exactly = 0) { mockConfigApi.changeApplicationCode(any(), any()) }
    }

    @Test
    fun testExecute_shouldInvokeChangeAppCodeOnEmarsys() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        every { mockConfigApi.changeApplicationCode(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(null)
        }
        every { mockEdit.putString(any(), any()) } returns mockEdit

        command.execute(mapOf("applicationCode" to APP_CODE), mockResultCallback)

        verify { mockResultCallback.invoke(null, null) }
        verify { mockConfigApi.changeApplicationCode(APP_CODE, any()) }
        verify {
            mockEdit.putString(
                ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name,
                APP_CODE
            )
        }
        verify { mockEdit.apply() }
    }

    @Test
    fun testExecute_shouldInvokeChangeAppCodeOnEmarsys_withError() {
        val mockResultCallback: ResultCallback = mockk(relaxed = true)
        val testError = Throwable()

        every { mockConfigApi.changeApplicationCode(any(), any()) } answers {
            secondArg<CompletionListener>().onCompleted(testError)
        }
        every { mockEdit.remove(any()) } returns mockEdit

        command.execute(mapOf("applicationCode" to APP_CODE), mockResultCallback)

        verify { mockResultCallback.invoke(null, testError) }
        verify { mockConfigApi.changeApplicationCode(APP_CODE, any()) }
        verify {
            mockEdit.remove(ConfigStorageKeys.MOBILE_ENGAGE_APPLICATION_CODE.name)
        }
        verify { mockEdit.apply() }
    }
}