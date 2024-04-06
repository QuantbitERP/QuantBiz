import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/invoice_list_model.dart';
import 'package:logger/logger.dart';
import '../constants.dart';

class InvoiceListServices{
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

  Future<List<InvoiceList>> fetchSaleInvoice() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Invoice?order_by=modified desc&fields=["name","customer_name","due_date","grand_total","status","total_qty"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<InvoiceList> caneList = List.from(jsonData['data'])
            .map<InvoiceList>((data) => InvoiceList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }


  Future<List<InvoiceList>> filterFetchSalesInvoice(String customerName, String date) async {
    baseurl = await geturl();
    try {
      var dio = Dio();

      // Construct the base URL
      String apiUrl =
          '$baseurl/api/resource/Sales Invoice?order_by=modified desc&fields=["name","customer_name","due_date","grand_total","status","total_qty"]';

      if(customerName.isNotEmpty && date.isNotEmpty){
        apiUrl += '&filters=[["customer_name", "=", "$customerName"],["due_date", "=", "$date"]]';
      }
      // Add filters based on conditions
      if(customerName.isNotEmpty) {
        apiUrl += '&filters=[["customer_name", "=", "$customerName"]]';
      }
      // Format the date in a way that your API expects, adjust as needed
      if(date.isNotEmpty) {

        apiUrl += '&filters=[["due_date", "=", "$date"]]';
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
        List<InvoiceList> orderList = List.from(jsonData['data'])
            .map<InvoiceList>((data) => InvoiceList.fromJson(data))
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