package com.iosdevlog.qiushibaike

import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder

class PullToRefreshAdapter : BaseQuickAdapter<Item, BaseViewHolder>(R.layout.qb_cell, ArrayList<Item>()) {

    override fun convert(helper: BaseViewHolder, item: Item) {
        helper.setImageResource(R.id.head_imageview, R.drawable.iosdevlog)
        helper.setText(R.id.content_textview, item.content)
    }
}
