import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/addquotation_model.dart';
import '../model/quotation_details_model.dart';


class AddQuotationServices {
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

  Future<List<String>> fetchquotationto() async {
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

  Future<List<String>> getcustomer(String quotaionto) async {
    baseurl =  await geturl();
    var data = {'doctype': quotaionto};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.quotation.get_customer_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
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
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];
  }

  Future<AddQuotation?> getquotation(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Quotation/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        // Logger().i(AddQuotation.fromJson(response.data["data"]));
        return AddQuotation.fromJson(response.data["data"]);
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
        return null;
      }
    } on DioException catch (e) {
      Logger().i(e.response);
      Fluttertoast.showToast(msg: "Error while fetching user");
    }
    return null;
  }

  Future<bool> updateOrder(AddQuotation quotationdetails) async {
    baseurl =  await geturl();

    Logger().i(quotationdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Quotation/${quotationdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: quotationdetails.toJson(),
      );

      if (response.statusCode == 200) {
        quotationStatus=response.data["data"]["docstatus"];
        Fluttertoast.showToast(msg: "Quotation Submitted successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Order!");
        return false;
      }
    } on DioException catch (e) {
       Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
       return false;
    }
   
  }
  Future<bool> cancelOrder(AddQuotation quotationdetails) async {
    baseurl =  await geturl();

    Logger().i(quotationdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Quotation/${quotationdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: quotationdetails.toJson(),
      );

      if (response.statusCode == 200) {
        quotationStatus=response.data["data"]["docstatus"];
        Fluttertoast.showToast(msg: "Quotation Cancelled successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Order!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
      return false;
    }

  }

  Future<String> addOrder(AddQuotation quotationdetails) async {
    try {
      baseurl = await geturl();
      var data = json.encode(quotationdetails);
      Logger().i(quotationdetails);

      var dio = Dio();
      var response = await dio.post(
        '$baseurl/api/method/mobile.mobile_env.quotation.create_order',
        options: Options(
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());
        Logger().i(response.data);
        quotationStatus=response.data["data"]["docstatus"];
        return response.data["data"]["name"].toString();
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Order!");
        return "";
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data['message'].toString());
      return "";
    }
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

  Future<List<QuotationDetailsModel>> quotationdetails(
      AddQuotation quotationdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      quotationdetails,
    );

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.quotation.prepare_quotation_detail',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<QuotationDetailsModel> caneList = List.from(jsonData['data'])
            .map<QuotationDetailsModel>((data) => QuotationDetailsModel.fromJson(data))
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
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data["message"].toString());
    }
    return [];
  }
}
