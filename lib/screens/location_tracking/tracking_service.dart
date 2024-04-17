import 'package:flutter/services.dart';

class TrackingService {
  static const platform = MethodChannel('tracking_service');

  static Future<void> startTracking() async {
    try {
      await platform.invokeMethod('startTracking', {'token': 'token 34dfee02f204abe:fb6cdb885da0ff9'});

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