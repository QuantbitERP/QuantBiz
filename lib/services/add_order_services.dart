import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/add_order_model.dart';
import '../model/order_details_model.dart';
import '../model/search_order_model.dart';

class AddOrderServices {
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

  Future<AddOrderModel?> getOrder(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(AddOrderModel.fromJson(response.data["data"]));
        return AddOrderModel.fromJson(response.data["data"]);
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

  Future<List<String>> fetchwarehouse() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.order.get_warehouselist',
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

  Future<bool> updateOrder(AddOrderModel orderdetails) async {
    baseurl =  await geturl();

    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order/${orderdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: orderdetails.toJson(),
      );

      if (response.statusCode == 200) {
        orderStatus=response.data["data"]['docstatus'];
        Fluttertoast.showToast(msg: "Order Submitted successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Order!");
        return false;
      }
    } on DioException catch (e) {
       Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return false;
  }

  Future<bool> cancelOrder(AddOrderModel orderdetails) async {
    baseurl =  await geturl();

    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order/${orderdetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: orderdetails.toJson(),
      );

      if (response.statusCode == 200) {
        orderStatus=response.data["data"]['docstatus'];
        Fluttertoast.showToast(msg: "Order Cancelled successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Order!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return false;
  }

  Future<String> addOrder(AddOrderModel orderdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      orderdetails,
    );
    Logger().i(orderdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.order.create_order',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());
        String name=response.data["data"]['name'].toString();
        orderStatus=response.data["data"]['docstatus'];
        return name;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Order!");
        return "";
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: const Color(0xFFBA1A1A),
        textColor: const Color(0xFFFFFFFF),
      );
      Logger().e(e);
    }
    return "";
  }

  Future<List<SearchCustomerList>> fetcustomer() async {
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
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<SearchCustomerList> caneList = List.from(jsonData['data'])
            .map<SearchCustomerList>((data) => SearchCustomerList.fromJson(data))
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

  Future<List<Items>> fetchitems(String warehouse) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.order.get_item_list?warehouse=$warehouse',
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

  Future<List<OrderDetailsModel>> orderdetails(

      AddOrderModel orderdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      orderdetails,
    );

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.order.prepare_order_totals',
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
