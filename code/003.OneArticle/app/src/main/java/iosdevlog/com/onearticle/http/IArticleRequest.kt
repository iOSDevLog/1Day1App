package iosdevlog.com.onearticle.http

import io.reactivex.Observable
import iosdevlog.com.onearticle.model.Article
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by e on 2018/1/18.
 */
interface IArticleRequestRequest {
    @GET("today")
    fun fetchTodayArticle(): Observable<Article>

    @GET("day")
    fun fetchArticelByDate(@Query("date") date: String): Observable<Article>


    @GET("random")
    fun fetchRandomArticle(): Observable<Article>
}