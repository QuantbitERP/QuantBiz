import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/add_visit_model.dart';

class AddVisitServices{
  Future<bool> addVisit(AddVisitModel lead) async {
    baseurl =  await geturl();
    var data = json.encode(
      lead,
    );

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.visit.create_visit',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {

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


  Future<AddVisitModel?> getVisit(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Visit/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(AddVisitModel.fromJson(response.data["data"]));
        return AddVisitModel.fromJson(response.data["data"]);
      } else {

        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }

  Future<List<String>> fetchcustomer() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.order.get_customer_list',
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
        Logger().i(namesList.length);
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Customer");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Customer!");
      return [];
    }
  }
  Future<List<String>> fetchVisitType() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Visit Type',
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
        Logger().i(namesList.length);
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Customer");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Customer!");
      return [];
    }
  }
}