import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/add_invoice_model.dart';
import '../model/order_details_model.dart';

class AddInvoiceServices{
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

  Future<AddInvoiceModel?> getOrder(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Invoice/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(AddInvoiceModel.fromJson(response.data["data"]));
        return AddInvoiceModel.fromJson(response.data["data"]);
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
        return null;
      }
    } on DioException catch (e) {
      Logger().i(e.response);
      Fluttertoast.showToast(msg: "Error while fetching Invoice");
    }
    return null;
  }


  Future<bool> updateOrder(AddInvoiceModel orderdetails) async {
    baseurl =  await geturl();
    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Invoice/${orderdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: orderdetails.toJson(),
      );

      if (response.statusCode == 200) {
        invoiceStatus=response.data["data"]['docstatus'];
        Fluttertoast.showToast(msg: "Invoice Submitted successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Invoice!");
        return false;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 417) {
        Html errorMessage = Html(data: e.response!.data["exception"]);


          // Handle NegativeStockError
          // String item = errorMessage.split("<a")[1].split(">")[1].split("<")[0].trim();
          // String warehouse = errorMessage.split("<a")[2].split(">")[1].split("<")[0].trim();

          Fluttertoast.showToast(
            gravity: ToastGravity.BOTTOM,
            msg: 'NegativeStock Error: ${errorMessage.data}',
            textColor: const Color(0xFFFFFFFF),
            backgroundColor: const Color(0xFFBA1A1A),
          );

          Logger().e("Negative Stock Error: $errorMessage");


        return false;
      } else {
        // Handle other DioException cases
        String? errorDetails = e.response?.data['exception'].toString();

        Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          msg: 'Error: $errorDetails',
          textColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFBA1A1A),
        );

        Logger().e("DioException: $errorDetails");
        return false;
      }
    }



  }

  Future<bool> cancelInvoice(AddInvoiceModel orderdetails) async {
    baseurl =  await geturl();
    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Invoice/${orderdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: orderdetails.toJson(),
      );

      if (response.statusCode == 200) {
        invoiceStatus=response.data["data"]['docstatus'];
        Fluttertoast.showToast(msg: "Invoice Cancelled successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Invoice!");
        return false;
      }
    } on DioException catch (e) {

        // Handle other DioException cases
        String? errorDetails = e.response?.data['exception'].toString();

        Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          msg: 'Error: $errorDetails',
          textColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFBA1A1A),
        );

        Logger().e("DioException: $errorDetails");
        return false;
      }
  }

  Future<String> addInvoice(AddInvoiceModel orderdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      orderdetails,
    );
    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.invoice.create_invoice',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast( msg: response.data['message'].toString(),);
        String name=response.data["data"]['name'].toString();
        invoiceStatus=response.data["data"]['docstatus'];
        Logger().i(response.data);
        return name;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Order!");
        return "";
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==417){
        Fluttertoast.showToast(
          msg: "${e.response?.data['message'].toString()}",
          backgroundColor: const Color(0xFFBA1A1A),
          textColor: const Color(0xFFFFFFFF),
        );
        Logger().e(e.response?.data['message'].toString());
      }else{
        Fluttertoast.showToast(
          msg: "${e.response?.data['message'].toString()}",
          backgroundColor: const Color(0xFFBA1A1A),
          textColor: const Color(0xFFFFFFFF),
        );
        Logger().e(e.response?.data['message'].toString());
      }

    }
    return "";
  }

  Future<List<String>> fetchwarehouse() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.invoice.get_warehouselist',
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
        Fluttertoast.showToast(msg: "Unable to fetch warehouse");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized warehouse!");
      return [];
    }
  }


  Future<List<InvoiceItems>> fetchitems(String? warehouse) async {

    baseurl =  await geturl();
    var data = {
      'warehouse': warehouse ?? ''
    };
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.invoice.get_item_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<InvoiceItems> caneList = List.from(jsonData['data'])
            .map<InvoiceItems>((data) => InvoiceItems.fromJson(data))
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

  Future<List<OrderDetailsModel>> orderdetails(

      AddInvoiceModel orderdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      orderdetails,
    );

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.invoice.prepare_order_totals',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<OrderDetailsModel> caneList = List.from(jsonData['data'])
            .map<OrderDetailsModel>((data) => OrderDetailsModel.fromJson(data))
            .toList();
        // Fluttertoast.showToast(msg: jsonData['message']);
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO add order details!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data["message"].toString()} ",
        backgroundColor: const Color(0xFFBA1A1A),
        textColor: const Color(0xFFFFFFFF),
      );
      Logger().e(e);
    }
    return [];
  }
}