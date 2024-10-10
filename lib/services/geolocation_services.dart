import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

class GeolocationService {


  Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }



      // Request location permission
      var locationPermissionStatus = await Permission.location.request();
      if (locationPermissionStatus != PermissionStatus.granted) {
        throw Exception('Location permissions are denied.');

      }


      // Request notification permission
      var notificationPermissionStatus = await Permission.notification.request();
      if (notificationPermissionStatus != PermissionStatus.granted) {
        throw Exception('Notification permissions are denied.');
      }

      // Check and request locationAlways permission if necessary


      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }




  Future<Placemark?> getPlacemarks(Position? position) async {
    try {
      List<Placemark> list = await placemarkFromCoordinates(
          position!.latitude, position.longitude);
      if (list.isNotEmpty) {
        Placemark placemark = list[0];
        return placemark;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Location data not available');
    }
    return null;
  }

  Future<double?> calculateDistance(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    const apiKey = '1cfcdeaf26352898f9975a577da9fd30';
    final url =
        'https://apis.mappls.com/advancedmaps/v1/$apiKey/distance_matrix/driving/$originLng,$originLat;$destinationLng,$destinationLat?rtype=0&region=IND';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        final distance = jsondata['results']['distances'][0][1];
        return distance;
      } else {
        throw Exception('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network-related exceptions here, e.g., for connectivity issues
      throw Exception('Error calculating distance: $e');
    }
  }

  Future<bool> employeeLocation(String longitude,String latitude,String deviceId) async {
    baseurl =  await geturl();
    var data = {'longitude': longitude.toString(),"latitude":latitude,"device_id":deviceId};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.location.user_location',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["message"].toString());
        // Fluttertoast.showToast(gravity: ToastGravity.SNACKBAR,msg: response.data["message"].toString().toUpperCase(),textColor:const Color(0xFFFFFFFF),backgroundColor: const Color.fromARGB(255, 26, 186, 29),);
        return true;
      } else {
        // Fluttertoast.showToast(msg: "Unable ot add employee log");
        return false;
      }
    } on DioException catch (e) {
      // Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      // Logger().e(e);
      Logger().i(e.response!.data["message"].toString());
    }
    return false;
  }

  Future<String?> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            '${placemark.street},${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
        return address;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to get address from coordinates');
    }
    return null;
  }
}
