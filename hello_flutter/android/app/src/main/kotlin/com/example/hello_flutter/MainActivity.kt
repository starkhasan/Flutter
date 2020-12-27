package com.example.hello_flutter

import android.app.Activity
import android.content.*
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.IBinder
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    var mService: MyService? = null
    var mBound = false
    var listener = MyBroadcastReceiver()
    var mEventSink:EventSink?=null
    var locationManager: LocationManager?=null
    var lati = 0.0
    var longt = 0.0
    companion object {
        const val REQUEST_CODE = 0xABC
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "startService_Channel").setMethodCallHandler { call, result ->
            if(call.method == "startService"){
                if(mService!=null && mBound){
                    unbindService(mConnection)
                    val intent = Intent(this,MyService::class.java)
                    intent.putExtra("Service",false)
                    stopService(intent)
                    mBound = false
                    result.success("Stopped")
                }else {
                    getCurrentLocation()
                    result.success("Started")
                }
            }else{
                result.notImplemented()
            }
        }

        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger,"com.example.hello_flutter")
        eventChannel.setStreamHandler(object:EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventSink?) {
                mEventSink = events
                //events!!.success("Any Event Ali hasan")
            }
            override fun onCancel(arguments: Any?) {}
        })
    }

    inner class MyBroadcastReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent){
            when (intent.action) {
                "FINISHED" -> {
                    if(mService!=null && mBound) {
                        val data = mService!!._apiResponse!!.new_order.toString()
                        mEventSink!!.success(data)
                    }
                }
                else -> Toast.makeText(applicationContext, "Couldn't get the result", Toast.LENGTH_SHORT).show()
            }
        }
    }

    fun getCurrentLocation(){
        if(ActivityCompat.checkSelfPermission(this,android.Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this,android.Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED){
            startService()
        }else{
            ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION,android.Manifest.permission.ACCESS_COARSE_LOCATION), REQUEST_CODE)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        when(requestCode) {
            REQUEST_CODE -> {
                if(grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED){
                    startService()
                }else{
                    Toast.makeText(applicationContext,"Please Grant Permission",Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        LocalBroadcastManager.getInstance(this).registerReceiver(listener, IntentFilter("FINISHED"))
    }

    override fun onDestroy() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(listener)
        super.onDestroy()
    }

    private fun startService(){
        val intent = Intent(this@MainActivity, MyService::class.java)
        intent.putExtra("Service",true)
        bindService(intent, mConnection, 0)
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            startForegroundService(intent)
        }else{
            startService(intent)
        }
    }

    val mConnection = object : ServiceConnection{
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            val binder: MyService.MyBinder = service as MyService.MyBinder
            mService = binder.getService()
            mBound = true
        }
        override fun onServiceDisconnected(p0: ComponentName?) {
            mBound = false
        }
    }

}

