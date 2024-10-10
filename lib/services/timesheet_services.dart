


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TimesheetServices{



  Future<void> createTimesheet(Map<String, dynamic> data, Map<String, dynamic> headers,BuildContext context) async {
    try {
      var response = await Dio().request(
        'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.create_timesheet',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());
       // Navigator.pop(context);
        print('Success: ${json.encode(response.data)}');
        // You can handle the successful response here, e.g., navigate to another page
      } else {
        print('Error: ${response.statusMessage}');
        // Handle error response
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exceptions, such as network errors
    }
  }




}