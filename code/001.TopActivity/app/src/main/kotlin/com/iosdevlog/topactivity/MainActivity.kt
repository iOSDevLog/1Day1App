package com.iosdevlog.topactivity

import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.preference.PreferenceManager
import android.provider.Settings
import android.support.v7.app.AppCompatActivity
import android.view.accessibility.AccessibilityManager
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.fragment_main.*

class MainActivity : AppCompatActivity() {

    private val mAccessibleIntent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
    private var serviceEnabled = false

    private var showTopActivityEnabled: Boolean
        get() {
            val preferenceManager = PreferenceManager.getDefaultSharedPreferences(applicationContext)
            return preferenceManager.getBoolean(SHOW_TOP_ACTIVITY_ENABLED, true)
        }
        set(value) {
            val preferenceManager = PreferenceManager.getDefaultSharedPreferences(applicationContext)
            preferenceManager.edit().putBoolean(SHOW_TOP_ACTIVITY_ENABLED, value).apply()
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        fab.setOnClickListener { startActivity(mAccessibleIntent) }
        service_switch.setOnCheckedChangeListener { _, isChecked ->
            showTopActivityEnabled = serviceEnabled && isChecked
        }
    }


    override fun onResume() {
        super.onResume()

        updateServiceStatus()
    }

    private fun updateServiceStatus() {
        val accessibilityManager = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        val accessibilityServices = accessibilityManager.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_GENERIC)
        serviceEnabled = accessibilityServices.any { it.id == packageName + "/.TopActivityAccessibilityService" }


        if (serviceEnabled) {
            service_textview.setText(R.string.services_on)
            fab.setImageResource(R.drawable.ic_stop_black_24dp)
        } else {
            service_textview.setText(R.string.services_off)
            fab.setImageResource(R.drawable.ic_play_arrow_black_24dp)
            showTopActivityEnabled = false
        }

        service_switch.isEnabled = serviceEnabled
        service_switch.isChecked = showTopActivityEnabled
    }
}
