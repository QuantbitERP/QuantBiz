import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/addquotation_model.dart';
import '../model/quotation_list_model.dart';

class QuotationServices {
  Future<List<QuotationList>> fetchquotation() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(

        '$baseurl/api/resource/Quotation?order_by=modified desc&fields=["name","customer_name","transaction_date","grand_total","status","total_qty"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<QuotationList> caneList = List.from(jsonData['data'])
            .map<QuotationList>((data) => QuotationList.fromJson(data))
            .toList();
        Logger().i(caneList);
        return caneList;

      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Quotation");
        return [];
      }
    } catch (e) {

      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Quotation!");
      return [];
    }
  }


  Future<List<QuotationList>> fetchfilterquotation(String quotaionto,String customerName) async {
    baseurl = await geturl();
    try {
      var dio = Dio();

      // Construct the base URL
      String apiUrl =
          '$baseurl/api/resource/Quotation?order_by=modified desc&fields=["name","customer_name","transaction_date","grand_total","status","total_qty"]';

      if(customerName.isNotEmpty && quotaionto.isNotEmpty){
        apiUrl += '&filters=[["customer_name", "=", "$customerName"],["quotation_to", "=", "$quotaionto"]]';
      }
      // Add filters based on conditions
      if(customerName.isNotEmpty) {
        apiUrl += '&filters=[["customer_name", "=", "$customerName"]]';
      }
      // Format the date in a way that your API expects, adjust as needed
      if(quotaionto.isNotEmpty) {
        apiUrl += '&filters=[["quotation_to", "=", "$quotaionto"]]';
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
        List<QuotationList> orderList = List.from(jsonData['data'])
            .map<QuotationList>((data) => QuotationList.fromJson(data))
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


  Future<List<String>> getcustomer() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.quotation.filter_customer_list',
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
        dataList.map((item) => item["customer_name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO get notes!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];
  }


  Future<List<Items>> fetchitems() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.quotation.get_item_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<Items> caneList = List.from(jsonData['data'])
            .map<Items>((data) => Items.fromJson(data))
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
