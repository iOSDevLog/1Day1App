package com.iosdevlog.topactivity

import android.accessibilityservice.AccessibilityService
import android.content.Context
import android.content.ServiceConnection
import android.graphics.PixelFormat
import android.os.Build
import android.preference.PreferenceManager
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.widget.TextView

class TopActivityAccessibilityService : AccessibilityService() {

    private var sWindowParams: WindowManager.LayoutParams? = null
    private var sWindowManager: WindowManager? = null
    private var sView: View? = null

    private var showTopActivityEnabled: Boolean
        get() {
            val preferenceManager = PreferenceManager.getDefaultSharedPreferences(applicationContext)
            return preferenceManager.getBoolean(SHOW_TOP_ACTIVITY_ENABLED, true)
        }
        set(value) {
            val preferenceManager = PreferenceManager.getDefaultSharedPreferences(applicationContext)
            preferenceManager.edit().putBoolean(SHOW_TOP_ACTIVITY_ENABLED, value).apply()
        }

    override fun onInterrupt() {
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (showTopActivityEnabled) {
            show(event!!.packageName.toString() + "\n" + event.className)
        } else {
            dismiss()
        }
    }

    override fun unbindService(conn: ServiceConnection?) {
        dismiss()
        super.unbindService(conn)
    }

    fun initView(context: Context) {
        sWindowManager = context.applicationContext
                .getSystemService(Context.WINDOW_SERVICE) as WindowManager

        val type = when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.O -> WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.N ->  WindowManager.LayoutParams.TYPE_TOAST
            else -> WindowManager.LayoutParams.TYPE_PHONE
        }
        sWindowParams = WindowManager.LayoutParams(
                WindowManager.LayoutParams.WRAP_CONTENT,
                WindowManager.LayoutParams.WRAP_CONTENT,
                type,
                0x18,
                PixelFormat.TRANSLUCENT)
        sWindowParams?.gravity = Gravity.START + Gravity.TOP
        sView = LayoutInflater.from(context).inflate(R.layout.top_activity_scrollview, null)
    }

    fun show(text: String) {
        if (sWindowManager == null) {
            initView(this)
            try {
                sWindowManager?.addView(sView, sWindowParams)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
        val textView = sView?.findViewById(R.id.text) as TextView?
        textView?.text = text
    }

    fun dismiss() {
        sWindowManager?.removeView(sView)
        sWindowManager = null
    }
}
