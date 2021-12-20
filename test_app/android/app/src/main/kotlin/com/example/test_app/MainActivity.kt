package com.example.test_app

import android.content.*
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.provider.MediaStore
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.test_app/battery_level"
    private val EVENT_CHANNEL = "com.example.test_app/location_service"
    private val PERMISSION_REQUEST_CODE = 1
    var listVideos = mutableListOf<VideoModel>()
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }else if(call.method == "readExternalFile") {
                filePermission()
                result.success(listVideos)
            }else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger,EVENT_CHANNEL).setStreamHandler(object: EventChannel.StreamHandler{
            override fun onListen(p0: Any?, eventSink: EventChannel.EventSink?) {
                eventSink!!.success("Any Value Sent From Backend")
            }

            override fun onCancel(p0: Any?) {
                TODO("Not yet implemented")
            }

        })
    }

    private fun filePermission(){
        if(ContextCompat.checkSelfPermission(this,android.Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED){
            loadFile()
        }else{
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                requestPermissions(arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE),PERMISSION_REQUEST_CODE)
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when(requestCode){
            PERMISSION_REQUEST_CODE ->{
                if(grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED){
                    loadFile()
                }else{
                    Toast.makeText(applicationContext,"Allow Permission for Better result",Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }

    private fun loadFile(){
        val uri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI
        val cursor = applicationContext.contentResolver.query(uri,null,null,null,null,null)
        listVideos.clear()
        while (cursor!!.moveToNext()){
            val name = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DISPLAY_NAME))
            val size = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.SIZE))
            val id = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Video.Media._ID))
            val url = ContentUris.withAppendedId(MediaStore.Video.Media.EXTERNAL_CONTENT_URI,id)
            listVideos.add(VideoModel(name,size,url.toString()))
        }
    }
}

