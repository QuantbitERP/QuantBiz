
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/full_screen_loader.dart';
import 'geolocation_model.dart';

class Geolocation extends StatelessWidget {
  const Geolocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GeolocationViewModel>.reactive(
      viewModelBuilder: () => GeolocationViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const AutoSizeText('Route details'),
          centerTitle: true,
        ),
        body: fullScreenLoader(
          child: Column(

            children: [
              Card(
                color: Colors.purple.shade50,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Text(
                        'User: ${model.geolocationdata.user ?? ""}',
                      ),
                      Text(
                        'Date:  ${model.geolocationdata.date}',
                      ),
                      Text(
                        'Device Id:  ${model.geolocationdata.deviceId}',
                      ),
                      // Text(
                      //   'Distance: ${model.geolocationdata.distance ?? 0.0}',
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: model.locations.isNotEmpty
                    ? FlutterMap(
                        options: MapOptions(
                            center: LatLng(
                                double.parse(
                                    model.locations[0].latitude ?? "0.0"),
                                double.parse(
                                    model.locations[0].longitude ?? "0.0")),

                            onMapReady: () => model.onMapReady),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                            // Plenty of other options available!
                          ),
                          MarkerLayer(
                            markers: model.locations.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final LatLng latLng = LatLng(
                                double.parse(entry.value.latitude ?? ""),
                                double.parse(entry.value.longitude ?? ""),
                              );

                              return Marker(
                                point: latLng,
                                builder: (ctx) {
                                  return Stack(
                                    children: [
                                      const Icon(Icons.location_on, size: 50),
                                      Positioned(
                                        left: 5,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            (index + 1).toString(),
                                            // Display the marker number
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          // MarkerLayer(
                          //   markers: model.parsedLocationTables.asMap().entries.map((entry) {
                          //     final int index = entry.key;
                          //     final LatLng latLng = LatLng(
                          //       double.parse(entry.value.latitude ?? ""),
                          //       double.parse(entry.value.longitude ?? ""),
                          //     );
                          //
                          //     return Marker(
                          //       point: latLng,
                          //       builder: (ctx) {
                          //         return Stack(
                          //           children: [
                          //             const Icon(Icons.location_on, size: 50),
                          //             Positioned(
                          //               left: 5,
                          //               top: 0,
                          //               right: 0,
                          //               child: Container(
                          //                 padding: const EdgeInsets.all(4),
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius:
                          //                   BorderRadius.circular(20),
                          //                 ),
                          //                 child: Text(
                          //                   (index + 1).toString(),
                          //                   // Display the marker number
                          //                   style: const TextStyle(
                          //                     color: Colors.black,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   }).toList(),
                          // ),
                          PolylineLayer(
                            polylineCulling: true,
                            polylines: [
                              Polyline(

                                  points:
                                   // model.points,
                                  model.locations.map((e) {
                                    return LatLng(double.parse(e.latitude ?? ""), double.parse(e.longitude ?? ""));
                                  }).toList(),
                                  color: Colors.blueAccent,
                                  strokeWidth: 8),
                              // Polyline(
                              //     points:
                              //     // model.points,
                              //     model.parsedLocationTables.map((e) {
                              //       return LatLng(double.parse(e.latitude ?? ""), double.parse(e.longitude ?? ""));
                              //     }).toList(),
                              //     color: Colors.yellowAccent,
                              //     strokeWidth: 5),
                            ],
                          ),
                        ],
                      )
                    : Container(
                        child: const Center(
                            child: Text('To see your location please checkin')),
                      ),
              ),

            ],
          ),
          loader: model.isBusy,
          context: context,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              model.initialise(context),
          child: const Icon(Icons.refresh_outlined),
        ),
      ),
    );
  }

// Define your background task logic here
}
