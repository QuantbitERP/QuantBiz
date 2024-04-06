import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/order_list_model.dart';

class OrderServices {
  Future<List<OrderList>> fetchsalesorder() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order?order_by=modified desc&fields=["name","customer_name","transaction_date","grand_total","status","total_qty"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<OrderList> caneList = List.from(jsonData['data'])
            .map<OrderList>((data) => OrderList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Orders!");
      return [];
    }
  }


  Future<List<OrderList>> filterfetchSalesOrder(String customerName, String date) async {
    baseurl = await geturl();
    try {
      var dio = Dio();

      // Construct the base URL
      String apiUrl =
          '$baseurl/api/resource/Sales Order?order_by=modified desc&fields=["name","customer_name","transaction_date","grand_total","status","total_qty"]';

      if(customerName.isNotEmpty && date.isNotEmpty){
        apiUrl += '&filters=[["customer_name", "=", "$customerName"],["transaction_date", "=", "$date"]]';
      }
      // Add filters based on conditions
      if(customerName.isNotEmpty) {
        apiUrl += '&filters=[["customer_name", "=", "$customerName"]]';
      }
     // Format the date in a way that your API expects, adjust as needed
      if(date.isNotEmpty) {

        apiUrl += '&filters=[["transaction_date", "=", "$date"]]';
      }
      //
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
        List<OrderList> orderList = List.from(jsonData['data'])
            .map<OrderList>((data) => OrderList.fromJson(data))
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

}
