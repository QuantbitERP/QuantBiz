import 'package:flutter/material.dart';
import 'package:geolocation/screens/location_tracking/show_maps_screen.dart';
import 'package:geolocation/screens/location_tracking/tracking_service.dart';



class LocationTracker extends StatefulWidget {
  @override
  _LocationTrackerState createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Flutter Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                TrackingService.startTracking();
              },
              child: Text('Start Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                TrackingService.stopTracking();
              },
              child: Text('Stop Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                //TrackingService.stopTracking();
                // Navigator.push(context, ShowMapsScreen())
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ShowMapsScreen()),
                );
              },
              child: Text('Show Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}