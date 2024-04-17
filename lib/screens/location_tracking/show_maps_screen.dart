import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class ShowMapsScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _MapsScreenState();
  }
}

class _MapsScreenState extends State<ShowMapsScreen> {
  List<dynamic> _locations = []; // Add this to hold fetched locations
  final MapController mapController = MapController();
  @override
  void initState() {
    super.initState();
    fetchLocations(); // Fetch locations when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Maps'),
      ),
      body: _buildMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Move the map to a new center
          mapController.move(const LatLng(52.0, -0.1), 13.0);
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }

  Widget _buildMap() {

    return FlutterMap(

      mapController: mapController,
      options: MapOptions(
        center: LatLng(double.parse(_locations[0]['latitude']), double.parse(_locations[0]['longitude'])),
        zoom: 3.5,
        onMapReady: _buildMarkers,
        onPositionChanged: (MapPosition pos, bool isGesture) {

      // Perform actions once the map is ready
      // For example, load markers here
      _buildMarkers();
    },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: _buildMarkers()),
       PolylineLayer(
          polylineCulling: true,
          polylines: [
            Polyline(
              isDotted: false,
              points: _locations.map((e) {
                // Access latitude and longitude from the map
                double lat = double.tryParse(e["latitude"] ?? "") ?? 0.0;
                double lng = double.tryParse(e["longitude"] ?? "") ?? 0.0;

                // Return a LatLng object
                return LatLng(lat, lng);
              }).toList(),
              color: Colors.blueAccent,
              strokeWidth: 12,
            )
          ],
        ),

      ],


    );
  }
  Future<void> fetchLocations() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.location.getLocation',
        options: Options(headers: {
          'Authorization': 'token 34dfee02f204abe:fb6cdb885da0ff9',
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = response.data; // No need to decode again
        var locationData = jsonData["data"];
        var locationTable = locationData["location_table"];
        setState(() {
          _locations = List.from(locationTable);
          //  _locations = locationData;
        });
      } else {
        // Handle other status codes if needed
        print('Failed to fetch locations');
      }
    } catch (e) {
      print('Error while fetching locations: $e');
      // Handle error
    }
  }

  List<Marker> _buildMarkers() {
    if(_locations.length == 0){
      return[] ;
    }
    return _locations.map((location) {
      print(location);
      var lat = double.tryParse(location['latitude']);
      var lng = double.tryParse(location['longitude']);

      return Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(lat!, lng!),
        builder:(context) {
          return Stack(
            children: [
              const Icon(Icons.location_on, size: 50),
              Positioned(left: 5, top: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: const Text("", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
            ],
          );
        });
    }
    ).toList();
  }

}




