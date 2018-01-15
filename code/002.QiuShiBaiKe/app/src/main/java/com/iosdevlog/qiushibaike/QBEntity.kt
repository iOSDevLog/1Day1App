package com.iosdevlog.qiushibaike

/**
 * Created by iosdevlog on 2018/1/15.
 */

data class QBEntity(
		val count: Int, //30
		val err: Int, //0
		val items: List<Item>,
		val total: Int, //1000
		val page: Int, //1
		val refresh: Int //1000
)

data class Item(
		val format: String, //word
		val image: String,
		val published_at: Int, //1515980402
		val tag: String,
		val user: User,
		val image_size: Any, //null
		val id: Int, //119935974
		val votes: Votes,
		val created_at: Int, //1515977312
		val content: String, //相熟的发型师给我发了个微信
		val state: String, //publish
		val comments_count: Int, //12
		val allow_comment: Boolean, //true
		val share_count: Int, //11
		val type: String //fresh
)

data class User(
		val avatar_updated_at: Int, //1515939457
		val created_at: Int, //1503937883
		val medium: String, ////pic.qiushibaike.com/system/avtnew/3435/34350130/medium/2018011422173698.JPEG
		val thumb: String, ////pic.qiushibaike.com/system/avtnew/3435/34350130/thumb/2018011422173698.JPEG
		val uid: Int, //34350130
		val last_visited_at: Int, //0
		val gender: String, //F
		val age: Int, //27
		val updated_at: Int, //1515939472
		val state: String, //active
		val role: String, //n
		val astrology: String, //狮子座
		val login: String, //晓颜诺诺
		val last_device: String, //android_10.14.2
		val id: Int, //34350130
		val icon: String //2018011422173698.JPEG
)

data class Votes(
		val down: Int, //-3
		val up: Int //82
)