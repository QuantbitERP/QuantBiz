import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class AddCustomerServices{
  Future<List<String>> fetchCustomerGroup() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Customer Group?page_limit_length=999',
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
        Fluttertoast.showToast(msg: "Unable to Customer Group");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }

  Future<List<String>> fetchTerritory() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Territory?limit_page_length=999',
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
        Fluttertoast.showToast(msg: "Unable to Territory");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }

  Future<bool> createCustomer(CreateCustomer customer) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.customer.create_customer',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: customer.toJson(),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: '${response.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFF006C50),);

        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  Future<CreateCustomer?> getCustomer(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.customer.get_customer?name=$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(CreateCustomer.fromJson(response.data["data"]));
        return CreateCustomer.fromJson(response.data["data"]);
      } else {

        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }
}