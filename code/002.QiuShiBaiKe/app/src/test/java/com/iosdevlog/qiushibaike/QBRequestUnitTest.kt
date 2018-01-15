package com.iosdevlog.qiushibaike

import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import org.junit.Test
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class QBRequestUnitTest {

    private val BASE_URL = "http://m2.qiushibaike.com/"

    @Test
    fun request_isSuccess() {
        val retrofit = Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build()

        val qbRequest = retrofit.create(IQBRequest::class.java)

        val page = 1
        qbRequest.fetchQBEntity(page)
                .subscribe({ result ->
                    println(result)
                    assert(result.items.count() > 0)
                    assert(result.count > 0)
                }, { error ->
                    println("onError")
                    error.printStackTrace()
                    assert(false)
                }, {
                    println("onComplete")
                    assert(true)
                }, {
                    println("start")
                })
    }
}
