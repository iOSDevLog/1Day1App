package iosdevlog.com.onearticle

import iosdevlog.com.onearticle.http.IArticleRequestRequest
import org.junit.Test

import org.junit.Assert.*
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class HttpUnitTest {
    private val BASE_URL = "https://interface.meiriyiwen.com/article/"

    @Test
    fun fetchTodayArticle() {
        val retrofit = Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build()

        val articleRequest = retrofit.create(IArticleRequestRequest::class.java)

        articleRequest.fetchTodayArticle()
                .subscribe({ result ->
                    println(result)
                    assert(result.data.content.isNotEmpty())
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
