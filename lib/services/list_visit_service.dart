import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/visit_list_model.dart';

class ListVisitServices{
  Future<List<VisitListModel>> fetchVisit() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(

        '$baseurl/api/method/mobile.mobile_env.visit.get_visit_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<VisitListModel> caneList = List.from(jsonData['data'])
            .map<VisitListModel>((data) => VisitListModel.fromJson(data))
            .toList();
        Logger().i(caneList.first.toJson());
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
}