package com.example.geolocation
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val channel = "tracking_service"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startTracking" -> {
                    val token: String? = call.argument("token")
                    print(token)
                    startTrackingService(token!!)
                    result.success(null)
                }
                "stopTracking" -> {
                    // stopTrackingService()
                    stopTrackingService()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    private fun startTrackingService(token:String) {

        val intent = Intent(this, LocationTrackingService::class.java)
        print(token)
        intent.putExtra("token",token)
        startForegroundService(intent)



    }

    private fun stopTrackingService() {
        val intent = Intent(this, LocationTrackingService::class.java)
        stopService(intent)
    }



}
