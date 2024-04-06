import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/customer_list_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class CustomerListService{
  Future<List<CustomerList>> fetchCustomerList() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Customer?fields=["customer_name","customer_group","territory","gst_category","name"]&order_by=modified desc',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CustomerList> caneList = List.from(jsonData['data'])
            .map<CustomerList>((data) => CustomerList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Lead");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }

  Future<List<CustomerList>> fetchFilterCustomer(String territory,String customerName) async {
    baseurl = await geturl();
    try {
      var dio = Dio();

      // Construct the base URL
      String apiUrl =
          '$baseurl/api/resource/Customer?fields=["customer_name","customer_group","territory","gst_category","name"]&order_by=modified desc';

      if(customerName.isNotEmpty && territory.isNotEmpty){
        apiUrl += '&filters=[["name", "=", "$customerName"],["territory", "=", "$territory"]]';
      }
      // Add filters based on conditions
      if(customerName.isNotEmpty) {
        apiUrl += '&filters=[["name", "=", "$customerName"]]';
      }
      // Format the date in a way that your API expects, adjust as needed
      if(territory.isNotEmpty) {
        apiUrl += '&filters=[["territory", "=", "$territory"]]';
      }
      //
      Logger().i(apiUrl);
      var response = await dio.request(
        apiUrl,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      Logger().i(apiUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CustomerList> orderList = List.from(jsonData['data'])
            .map<CustomerList>((data) => CustomerList.fromJson(data))
            .toList();
        Logger().i(orderList.length);
        return orderList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }

  Future<List<String>> fetchterritory() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Territory?limit_page_length=99',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch industry type");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized industry!");
      return [];
    }
  }

  Future<List<String>> getcustomer() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.customer.filter_customer_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO get notes!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];
  }
}