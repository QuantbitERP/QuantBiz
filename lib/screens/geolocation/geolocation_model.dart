import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../model/gelocation_model.dart';
import '../../services/checkin_services.dart';
import 'package:http/http.dart' as http;

class GeolocationViewModel extends BaseViewModel {
  List<LocationTable> locations = [];
  List<String> leadlist = [""];
  GeolocationModel geolocationdata = GeolocationModel();
  String locationid = "";
  List<LocationTable> parsedLocationTables=[];
  void initialise(BuildContext context) async {
    setBusy(true);

    geolocationdata =
        await CheckinServices().getmember(locationid) ?? GeolocationModel();

    locations.addAll(geolocationdata.locationTable?.toList() ?? []);
    getCoordinates(geolocationdata.locationTable ?? []);
    Logger().i(geolocationdata.locationTable.toString());
    notifyListeners();
    setBusy(false);
  }

  List listOfPoints = [];

// Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

// Method to consume the OpenRouteService API
  getCoordinates(List<LocationTable> location) async {
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      var response = await http.get(getRouteUrl(
        "${location[0].longitude},${location[0].latitude}",
        "${location.last.longitude},${location.last.latitude}",
      ));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
        Logger().i(listOfPoints.toString());
      }
    } else {
      // Handle the case where the location list is empty
    }
    notifyListeners();
  }

// Handle directionsResponse
  void onMapReady() async {

    geolocationdata =
        await CheckinServices().getmember(locationid) ?? GeolocationModel();
    // leadlist = await homeservices().fetchLead();
    locations.addAll(geolocationdata.locationTable?.toList() ?? []);
  }
}
