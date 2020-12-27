package com.example.hello_flutter

import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.PixelFormat
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.media.MediaPlayer
import android.os.*
import android.provider.Settings
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.google.gson.Gson
import okhttp3.*
import java.io.IOException


class MyService : Service(){

    private val client = OkHttpClient()
    private val mBinder:IBinder = MyBinder()
    var _apiResponse: APIResponse ?= null
    val localBroadcastManager = LocalBroadcastManager.getInstance(this@MyService)
    var locationManager: LocationManager?=null
    var lat = 0.0
    var longt = 0.0
    var order_status = 0
    var mediaPlayer : MediaPlayer ?= null

    var ACTION_MANAGE_OVERLAY_PERMISSION_REQUEST_CODE = 5469
    private var topLeftView: View? = null

    private var overlayedButton: Button? = null
    private val offsetX = 0f
    private val offsetY = 0f
    private val originalXPos = 0
    private val originalYPos = 0
    private val moving = false
    private var wm: WindowManager? = null
    private var serviceFlag = false

    override fun onBind(p0: Intent?): IBinder? {
        return mBinder
    }

    inner class MyBinder : Binder() {
        fun getService(): MyService = this@MyService
    }

    override fun onCreate() {
        super.onCreate()
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            val builder = NotificationCompat.Builder(this, "messages")
                    .setContentTitle("Searching Orders...")
                    .setSmallIcon(R.drawable.small_icon)
            startForeground(101, builder.build())
            _callAPI()
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        serviceFlag = intent!!.extras.get("Service") as Boolean
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceFlag = false
    }

    fun OverLayPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if(!Settings.canDrawOverlays(MyService@this)){
                val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            }else{
                showDialog()
            }
        }
    }

    fun timer(){
        object: CountDownTimer(10000, 1000){
            override fun onTick(p0: Long) {
            }
            override fun onFinish() {
                if(serviceFlag)
                    _callAPI()
            }
        }.start()
    }

    private fun _callAPI(){
        if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return
        }
        locationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val isGpsEnabled = locationManager!!.isProviderEnabled(LocationManager.GPS_PROVIDER)
        if(isGpsEnabled){
            locationManager?.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0L, 0f, locationListener)
        }else{
            Toast.makeText(applicationContext, "Please Open GPS", Toast.LENGTH_SHORT).show()
        }
        run("12", lat.toString(), longt.toString())
    }

    private val locationListener : LocationListener = object : LocationListener {
        override fun onLocationChanged(location: Location?) {
            lat = location!!.latitude
            longt = location!!.longitude
        }
        override fun onStatusChanged(p0: String?, p1: Int, p2: Bundle?) {}
        override fun onProviderEnabled(p0: String?) {}
        override fun onProviderDisabled(p0: String?) {}

    }

    private fun run(Id: String, latitude: String, longitude: String){
        val requestBody = FormBody.Builder()
                .add("id", Id)
                .add("latitude", latitude)
                .add("longitude", longitude)
                .build()
        val request = Request.Builder()
                .url("https://run.mocky.io/v3/cff23b51-74ed-49c5-9767-0162c7fdc8ac")
                .addHeader("Token", "4DF45SD4FDFS4DDS5DDFSDDFfsdfdcDFSDFS")
                .post(requestBody)
                .build()
        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
            }

            override fun onResponse(call: Call, response: Response) {
                if (response.isSuccessful) {
                    val gson = Gson()
                    val data = gson.fromJson(response.body?.string(), APIResponse::class.java)
                    _apiResponse = data
                    localBroadcastManager.sendBroadcast(Intent("FINISHED"))
                    Handler(Looper.getMainLooper()).post(object : Runnable {
                        override fun run() {
                            timer()
                        }
                    })
                    Handler(Looper.getMainLooper()).postDelayed(object : Runnable {
                        override fun run() {
                            OverLayPermission()
                        }
                    }, 10000)
                }
            }
        })
    }

    private fun showDialog(){
        serviceFlag = false
        mediaPlayer =  MediaPlayer.create(this,R.raw.deliver_alert)
        mediaPlayer!!.setVolume(1.0f,1.0f)
        mediaPlayer!!.isLooping = true
        mediaPlayer!!.start()
        wm = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val params = WindowManager.LayoutParams(WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.OPAQUE)
        val visitorAlertView = LayoutInflater.from(this).inflate(R.layout.overlay_visitor_alert, null)
        wm!!.addView(visitorAlertView, params)
        val acceptBotton = visitorAlertView.findViewById<LinearLayout>(R.id.llAccept)
        acceptBotton.setOnClickListener {
            _orderAPICall("12")
            if(order_status > 0){
                mediaPlayer!!.stop()
                mediaPlayer!!.release()
                wm!!.removeView(visitorAlertView)
                val intent = Intent(this,MainActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
                this.stopSelf()
            }
        }
        val rejectButton = visitorAlertView.findViewById<LinearLayout>(R.id.llReject)
        rejectButton.setOnClickListener {
            if(mediaPlayer!=null && wm!=null) {
                mediaPlayer!!.stop()
                wm!!.removeView(visitorAlertView)
                serviceFlag = true
            }
        }
    }

    private fun _orderAPICall(orderId:String){
        val requestBody = FormBody.Builder()
                .add("id", orderId)
                .build()
        val request = Request.Builder()
                .url("https://run.mocky.io/v3/cff23b51-74ed-49c5-9767-0162c7fdc8ac")
                .addHeader("Token", "4DF45SD4FDFS4DDS5DDFSDDFfsdfdcDFSDFS")
                .post(requestBody)
                .build()
        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
            }

            override fun onResponse(call: Call, response: Response) {
                if (response.isSuccessful) {
                    val gson = Gson()
                    val data = gson.fromJson(response.body?.string(), APIResponse::class.java)
                    order_status = data.status
                    Handler(Looper.getMainLooper()).post(object : Runnable {
                        override fun run() {
                            Toast.makeText(this@MyService,data.message,Toast.LENGTH_SHORT).show()

                        }
                    })
                }
            }
        })
    }
}