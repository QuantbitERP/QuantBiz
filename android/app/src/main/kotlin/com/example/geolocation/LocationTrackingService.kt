package com.example.geolocation

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.os.Build
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import androidx.core.content.ContextCompat
import com.example.geolocation.MainActivity
import com.example.geolocation.R
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.Granularity
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import okhttp3.Call
import okhttp3.Callback
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import okio.IOException
import org.json.JSONObject

class LocationTrackingService: Service() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationCallback: LocationCallback
    private val TAG = "LocationTrackingService"
    private val NOTIFICATION_ID = 12345
    private val CHANNEL_ID = "LocationTrackingChannel"
    private var token = ""

    override fun onCreate() {
        super.onCreate()
        //ServiceCompat.startForeground(0, notification, FOREGROUND_SERVICE_TYPE_LOCATION)

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

    fun uploadLocationToServer(location: Location) {
        val url = "https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.location.user_location"

        // Create JSON object with location data
        val jsonLocation = JSONObject()
        jsonLocation.put("latitude", location.latitude)
        jsonLocation.put("longitude", location.longitude)
        jsonLocation.put("device_id", "ABC123")

        // Create HTTP request body with JSON data
        val body =
            RequestBody.create("application/json".toMediaTypeOrNull(), jsonLocation.toString())

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

    fun uploadLocationToTrackerServer(location: Location) {
        val url = "http://65.109.234.11:8082/api/method/mobile.mobile_env.location.user_location"

        // Create JSON object with location data
        val jsonLocation = JSONObject()
        jsonLocation.put("latitude", location.latitude)
        jsonLocation.put("longitude", location.longitude)
        jsonLocation.put("device_id", "ABC123")

        // Create HTTP request body with JSON data
        val body =
            RequestBody.create("application/json".toMediaTypeOrNull(), jsonLocation.toString())

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
