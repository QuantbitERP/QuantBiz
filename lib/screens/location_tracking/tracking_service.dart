import 'package:flutter/services.dart';
import 'package:geolocation/constants.dart';

class TrackingService {
  static const platform = MethodChannel('tracking_service');

  static Future<void> startTracking() async {
    try {
      var token = await getTocken();
      await platform.invokeMethod('startTracking', {'token': token});

    } on PlatformException catch (e) {
      print("Failed to start tracking: '${e.message}'.");
    }
  }

  static Future<void> stopTracking() async {
    try {
      await platform.invokeMethod('stopTracking');
    } on PlatformException catch (e) {
      print("Failed to stop tracking: '${e.message}'.");
    }
  }
}