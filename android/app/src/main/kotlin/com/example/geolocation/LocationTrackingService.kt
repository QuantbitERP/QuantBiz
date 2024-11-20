package com.quantbit.crm

import android.Manifest
import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Address
import android.location.Geocoder
import android.location.Location
import android.os.Build
import android.os.IBinder
import android.os.Looper
import android.provider.Settings
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import androidx.core.content.ContextCompat


import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.Granularity
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.quantbit.crm.R
import okhttp3.Call
import okhttp3.Callback
import okhttp3.HttpUrl
import okhttp3.HttpUrl.Companion.toHttpUrlOrNull
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okio.IOException
import org.json.JSONObject
import java.util.Locale

class LocationTrackingService: Service() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationCallback: LocationCallback
    private val TAG = "LocationTrackingService"
    private val NOTIFICATION_ID = 12345
    private val CHANNEL_ID = "LocationTrackingChannel"
    private var token = ""
    private lateinit var geocoder: Geocoder

    @SuppressLint("ForegroundServiceType")
    override fun onCreate() {
        super.onCreate()
        //ServiceCompat.startForeground(0, notification, FOREGROUND_SERVICE_TYPE_LOCATION)
        geocoder = Geocoder(this, Locale.getDefault())
        startForeground(NOTIFICATION_ID, createNotification())
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        startLocationUpdates()
        Log.d("LocationTrackingService", "Service started")
        println("On  service gets called")

    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent != null) {
            token = intent.getStringExtra("token").toString()
        }
        return START_STICKY

    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }


    private fun startLocationUpdates() {
//        val locationRequest = LocationRequest.create().apply {
//            interval = 1 * 60 * 1000 // 15 minutes in milliseconds
//            fastestInterval = 1 * 60 * 1000 // 15 minutes in milliseconds
//            priority = LocationRequest.PRIORITY_HIGH_ACCURACY
//        }
        val locationRequest =  LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, 1*60*1000).apply {
            setIntervalMillis(1*60*1000)
            setGranularity(Granularity.GRANULARITY_PERMISSION_LEVEL)
            setWaitForAccurateLocation(true)
        }.build()


        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                locationResult.lastLocation?.let { location ->
                    println(location.toString())
                    // Handle the received location (e.g., upload to server)
                    uploadLocationToServer(location)
                    updateNotification(location)
                }
            }
        }

        if (checkLocationPermission()) {
            fusedLocationClient.requestLocationUpdates(
                locationRequest,
                locationCallback,
                Looper.myLooper()!!
            )
        }
    }


    @SuppressLint("HardwareIds")
    fun uploadLocationToServer(location: Location) {
        val url = "https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.location.user_location"
        val mId = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
        // Create JSON object with location data
        val jsonLocation = JSONObject()
        jsonLocation.put("latitude", location.latitude)
        jsonLocation.put("longitude", location.longitude)
        jsonLocation.put("device_id", mId)

        // Create HTTP request body with JSON data
        val body =
            jsonLocation.toString().toRequestBody("application/json".toMediaTypeOrNull())

        // Create HTTP request
        val request = Request.Builder()
            .url(url)
            .addHeader("Authorization", token)
            .post(body)
            .build()

        // Create OkHttpClient instance
        val client = OkHttpClient()

        // Send HTTP request asynchronously
        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                // Handle failure to send data
                e.printStackTrace()
                println(e.message)
            }

            override fun onResponse(call: Call, response: Response) {
                // Handle response from server
                if (response.isSuccessful) {
                    // Data uploaded successfully
                    println("Location data uploaded successfully")
                } else {
                    // Handle server error
                    println("Server error: ${response.code}")
                }
            }
        })
    }

    private fun updateNotification(location: Location?) {
        val notificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val notificationId = 101 // Notification ID used when starting the foreground service

        val area = getAreaFromLocation(location)
        val contentText = "You are in $area now"

        val notificationBuilder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Location Service")
            .setContentText(contentText)
            .setSmallIcon(R.drawable.common_full_open_on_phone)
            .setPriority(NotificationCompat.PRIORITY_LOW)

        // If you want to update the notification, use the same notification ID
        notificationManager.notify(NOTIFICATION_ID, notificationBuilder.build())
    }

    private fun getAreaFromLocation(location: Location?): String {
        val addresses: MutableList<Address>? =
            geocoder.getFromLocation(location?.latitude ?: 0.0, location?.longitude ?: 0.0, 1)
        return if (addresses!!.isNotEmpty()) {
            addresses[0].locality ?: addresses[0].subAdminArea ?: addresses[0].adminArea ?: ""
        } else {
            "Unknown Area"
        }
    }

    fun uploadLocationToTrackerServer(location: Location) {
       // val url = "http://65.109.234.11:8082/?id=442271&timestamp=1713345062&lat=18.5204&lon=73.8567&speed=0.0&bearing=0.0&altitude=509.1999816894531&accuracy=15.015999794006348&batt=100.0&charge=true"
        val url = "http://65.109.234.11:8082/"
        val m8Id = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
        // Create JSON object with location data
        val jsonLocation = JSONObject()
        jsonLocation.put("latitude", location.latitude)
        jsonLocation.put("longitude", location.longitude)
        jsonLocation.put("deviceId", "442271")
        jsonLocation.put("timestamp",System.currentTimeMillis())

        val urlBuilder = url.toHttpUrlOrNull()?.newBuilder()
        urlBuilder?.addQueryParameter("id", "353136")
        urlBuilder?.addQueryParameter("timestamp", System.currentTimeMillis().toString())
        urlBuilder?.addQueryParameter("lat", "28.2180")
        urlBuilder?.addQueryParameter("lon","94.7278" )
//        urlBuilder?.addQueryParameter("speed", "0.0")
//        urlBuilder?.addQueryParameter("bearing", "0.0")
//        urlBuilder?.addQueryParameter("altitude", "509.1999816894531")
//        urlBuilder?.addQueryParameter("accuracy", "15.015999794006348")
//        urlBuilder?.addQueryParameter("batt", "100.0")
//        urlBuilder?.addQueryParameter("charge", "true")

        val urlString = urlBuilder?.build().toString()
        val emptyBody = "".toRequestBody(null)
        kotlin.io.print(urlString)

        // Create HTTP request body with JSON data
        val body =
            jsonLocation.toString().toRequestBody("application/json".toMediaTypeOrNull())

        // Create HTTP request
        val request = Request.Builder()
            .url(urlString)
            .post(emptyBody)
            .build()

        // Create OkHttpClient instance
        val client = OkHttpClient()

        // Send HTTP request asynchronously
        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                // Handle failure to send data
                e.printStackTrace()
                println(e.message)
            }

            override fun onResponse(call: Call, response: Response) {
                // Handle response from server
                if (response.isSuccessful) {
                    // Data uploaded successfully
                    println(response.body)
                    println("Location data uploaded successfully")
                } else {
                    // Handle server error
                    println("Server error: ${response.code}")
                }
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        fusedLocationClient.flushLocations()
        fusedLocationClient.removeLocationUpdates(locationCallback)
    }

    private fun createNotification(): Notification {
        createNotificationChannel()
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Location Tracking")
            .setContentText("Tracking your location")
            .setSmallIcon(R.drawable.common_full_open_on_phone)
            .setContentIntent(pendingIntent)
            .setPriority(NotificationCompat.PRIORITY_HIGH) // Set priority to high
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC) //
            .build()
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID,
            "Location Tracking Channel",
            NotificationManager.IMPORTANCE_DEFAULT
        )

        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(channel)
    }

    private fun checkLocationPermission(): Boolean {
        return ActivityCompat.checkSelfPermission(
            applicationContext,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
            applicationContext,
            Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
    }
}
