


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class TimesheetServices{



  // Future<void> createTimesheet(Map<String, dynamic> data, Map<String, dynamic> headers,BuildContext context) async {
  //   try {
  //     var response = await Dio().request(
  //       'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.create_timesheet',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(msg: response.data['message'].toString());
  //      // Navigator.pop(context);
  //       print('Success: ${json.encode(response.data)}');
  //       // You can handle the successful response here, e.g., navigate to another page
  //     } else {
  //       print('Error: ${response.statusMessage}');
  //       // Handle error response
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     // Handle exceptions, such as network errors
  //   }
  // }

  Future<bool> createTimesheet(
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      BuildContext context) async {
        try {
          var response = await Dio().request(
            'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.create_timesheet',
            options: Options(
              method: 'POST',
              headers: headers,
            ),
            data: data,
          );

          if (response.statusCode == 200 && response.data['message'] == 'Timesheet has been updated successfully') {
            Fluttertoast.showToast(msg: response.data['message'].toString());
            print('Success: ${json.encode(response.data)}');
            return true;
          } else {
            Fluttertoast.showToast(msg: response.data['message'].toString());
            print('Error: ${json.encode(response.data)}');
            return false;
          }
        } catch (e) {
          Fluttertoast.showToast(msg: '$e');
          print('Exception: $e');
          return false;
        }
  }


  Future<List<String>> fetchActivityTypes() async {
    var token = await getTocken();
    var dio = Dio();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':token, // Replace with actual token
    };

    try {
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.app.get_activity_types',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Map<String, dynamic> jsonData = json.decode(response.data);
        // List<String> activityTypes = List<String>.from(jsonData['data'].map((activity) => activity['name']));
        // Parse the JSON response string into a Map
        Map<String, dynamic> parsedJson = response.data;  // Ensure this is a string and then decoded

        // Ensure 'data' is treated as a List of Maps
        List<dynamic> dataList = parsedJson['data'];  // 'data' is a list of maps

        // Extracting the list of names
        List<String> activityNames = dataList.map((activity) => activity['name'].toString()).toList();
        return activityNames;
      } else {
        throw Exception('Failed to fetch activity types: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }





}