package com.iosdevlog.qiushibaike

import android.graphics.*
import android.widget.ImageView
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder
import com.squareup.picasso.Picasso
import com.squareup.picasso.Transformation
import java.text.SimpleDateFormat
import java.util.*

class PullToRefreshAdapter : BaseQuickAdapter<Item, BaseViewHolder>(R.layout.qb_cell, ArrayList<Item>()) {

    override fun convert(helper: BaseViewHolder, item: Item) {
        if (item.user != null) {
            val imageView = helper.getView<ImageView>(R.id.head_imageview)
            Picasso.with(mContext)
                    .load("http:" + item.user.medium)
                    .resize(40, 40)
                    .centerCrop()
                    .transform(CircleTransform())
                    .into(imageView)
            helper.setText(R.id.username_textview, item.user.login)
            helper.setText(R.id.username_detail, item.user.age.toString() + " " + item.user.astrology + " 赞: " + item.votes.up + " 踩: " + item.votes.down)

            val gender = when (item.user.gender) {
                "F" -> R.drawable.female
                "M" -> R.drawable.male
                else -> R.drawable.male
            }
            helper.setImageResource(R.id.gender_imageview, gender)
        }

        val published_at = java.lang.Long.valueOf(item.published_at)
        val simpleDateFormat = SimpleDateFormat("yyyy-MM-dd\nHH:mm:ss")
        val published_string = simpleDateFormat.format( Date(published_at * 1000L));
        helper.setText(R.id.datetime_textview, published_string)
        helper.setText(R.id.content_textview, item.content)
    }

    inner class CircleTransform : Transformation {
        override fun transform(source: Bitmap): Bitmap {
            val size = Math.min(source.width, source.height)

            val x = (source.width - size) / 2
            val y = (source.height - size) / 2

            val squaredBitmap = Bitmap.createBitmap(source, x, y, size, size)
            if (squaredBitmap != source) {
                source.recycle()
            }

            val config = if (source.config != null) source.config else Bitmap.Config.ARGB_8888
            val bitmap = Bitmap.createBitmap(size, size, config)

            val canvas = Canvas(bitmap)
            val paint = Paint()
            val shader = BitmapShader(squaredBitmap, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP)
            paint.setShader(shader)
            paint.setAntiAlias(true)

            val r = size / 2f
            canvas.drawCircle(r, r, r, paint)

            squaredBitmap.recycle()
            return bitmap
        }

        override fun key(): String {
            return "circle"
        }
    }
}
