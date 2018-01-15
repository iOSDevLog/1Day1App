package com.iosdevlog.qiushibaike

import android.graphics.Color
import android.os.Bundle
import android.support.v4.widget.SwipeRefreshLayout
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.util.Log
import android.view.View
import android.widget.Toast
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.listener.OnItemClickListener
import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import android.support.v7.widget.RecyclerView
import io.reactivex.Observable

class MainActivity : AppCompatActivity(), BaseQuickAdapter.RequestLoadMoreListener, SwipeRefreshLayout.OnRefreshListener, Thread.UncaughtExceptionHandler {

    private lateinit var mRecyclerView: RecyclerView
    private lateinit var pullToRefreshAdapter: PullToRefreshAdapter
    private lateinit var mSwipeRefreshLayout: SwipeRefreshLayout

    private var currentPage = 0

    // LifeCycle
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Thread.setDefaultUncaughtExceptionHandler(this)

        mRecyclerView = findViewById(R.id.recycleview)
        mSwipeRefreshLayout = findViewById(R.id.swipeLayout)
        mSwipeRefreshLayout.setOnRefreshListener(this)
        mSwipeRefreshLayout.setColorSchemeColors(Color.YELLOW)
        mRecyclerView.layoutManager = LinearLayoutManager(this)

        initAdapter()
    }

    override fun onResume() {
        super.onResume()

        onRefresh()
    }

    // UncaughtExceptionHandler
    override fun uncaughtException(t: Thread?, e: Throwable?) = e!!.printStackTrace()

    // Refresh
    override fun onLoadMoreRequested() {
        mSwipeRefreshLayout.isEnabled = false

        fetch(currentPage).subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({ result ->
                    Log.d(TAG, result.toString())

                    pullToRefreshAdapter.addData(result.items)
                }, { error ->
                    error.printStackTrace()

                    mSwipeRefreshLayout.isEnabled = true
                    mSwipeRefreshLayout.isRefreshing = false
                    Toast.makeText(this@MainActivity, R.string.network_error, Toast.LENGTH_LONG).show()
                    pullToRefreshAdapter.setEnableLoadMore(true)

                    pullToRefreshAdapter.loadMoreFail()
                }, {
                    Log.d(TAG, "onComplete")

                    currentPage += 1
                    mSwipeRefreshLayout.isEnabled = true
                    mSwipeRefreshLayout.isRefreshing = false
                    pullToRefreshAdapter.setEnableLoadMore(true)

                    pullToRefreshAdapter.loadMoreComplete()
                }, {
                    Log.d(TAG, "onStart")
                })
    }

    override fun onRefresh() {
        pullToRefreshAdapter.setEnableLoadMore(false)

        currentPage = 1
        fetch(currentPage).subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({ result ->
                    Log.d(TAG, result.toString())

                    pullToRefreshAdapter.setNewData(result.items)
                }, { error ->
                    Log.d(TAG, "onError")

                    error.printStackTrace()
                    mSwipeRefreshLayout.isRefreshing = false
                    pullToRefreshAdapter.setEnableLoadMore(true)
                }, {
                    Log.d(TAG, "onComplete")
                    mSwipeRefreshLayout.isRefreshing = false
                    pullToRefreshAdapter.setEnableLoadMore(true)
                    currentPage += 1
                }, {
                    Log.d(TAG, "onStart")
                })
    }

    // Helper
    private fun initAdapter() {
        pullToRefreshAdapter = PullToRefreshAdapter()
        pullToRefreshAdapter.setOnLoadMoreListener(this, mRecyclerView)
        pullToRefreshAdapter.openLoadAnimation(BaseQuickAdapter.SLIDEIN_BOTTOM)
        mRecyclerView.adapter = pullToRefreshAdapter

        mRecyclerView.addOnItemTouchListener(object : OnItemClickListener() {
            override fun onSimpleItemClick(adapter: BaseQuickAdapter<*, *>, view: View, position: Int) {
                Toast.makeText(this@MainActivity, Integer.toString(position), Toast.LENGTH_LONG).show()
            }
        })
    }

    private fun fetch(page: Int): Observable<QBEntity> {
        val retrofit = Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build()

        val qbRequest = retrofit.create(IQBRequest::class.java)

        return qbRequest.fetchQBEntity(page)
    }

    companion object {
        private val BASE_URL = "http://m2.qiushibaike.com/"
        private val TAG = MainActivity::class.java.simpleName
    }
}
