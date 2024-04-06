import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/comment_List_model.dart';

class UpdateCustomerService{
  Future<List<CommentList>> fetchComments(String name) async {

    baseurl =  await geturl();
    var data = {
      "reference_doctype":"Customer",
      'reference_name': name
    };
    try {
      var dio = Dio();
      var response = await dio.request(
          '$baseurl/api/method/mobile.mobile_env.app.get_comments',
          options: Options(
            method: 'GET',
            headers: {'Authorization': await getTocken()},
          ),
          data: data
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CommentList> caneList = List.from(jsonData['data'])
            .map<CommentList>((data) => CommentList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch items");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "$e");
      return [];
    }
  }

  Future<bool> addComment(String name,dynamic note) async {
    baseurl =  await geturl();
    var data = {
      "reference_doctype":"Customer",
      'reference_name': name,'content':note};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.add_comment',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["message"]);
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO add notes!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  Future<List<CustOrderList>> fetchCustomerOrder(String name) async {

    baseurl =  await geturl();

    try {
      var dio = Dio();
      var response = await dio.request(
          '$baseurl/api/resource/Sales Order?limit_page_length=10&filters=[["customer","=","$name"]]&fields=["name","delivery_date","rounded_total"]&order_by=creation desc',
          options: Options(
            method: 'GET',
            headers: {'Authorization': await getTocken()},
          ),

      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CustOrderList> caneList = List.from(jsonData['data'])
            .map<CustOrderList>((data) => CustOrderList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch items");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "$e");
      return [];
    }
  }

  Future<List<CustOrderList>> fetchFilterCustomerOrder(String name,String status) async {

    baseurl =  await geturl();

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order?limit_page_length=10&filters=[["customer","=","$name"],["delivery_status","=","$status"]]&fields=["name","delivery_date","rounded_total"]&order_by=creation desc',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),

      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CustOrderList> caneList = List.from(jsonData['data'])
            .map<CustOrderList>((data) => CustOrderList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch items");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "$e");
      return [];
    }
  }
}