package com.iosdevlog.qiushibaike

import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by iosdevlog on 2018/1/15.
 */
interface IQBRequest {
    @GET("article/list/text")
    fun fetchQBEntity(@Query("page") page: Int): Observable<QBEntity>
}
