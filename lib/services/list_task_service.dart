import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/list_task_model.dart';

class TaskListService{
  Future<List<TaskList>> fetchTask() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(

        '$baseurl/api/method/mobile.mobile_env.task.get_task_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<TaskList> caneList = List.from(jsonData['data'])
            .map<TaskList>((data) => TaskList.fromJson(data))
            .toList();

        return caneList;

      } else {
        Fluttertoast.showToast(msg: "Unable to task List");
        return [];
      }
    } on DioException catch (e) {

      Logger().e(e.response?.data['message'].toString());
      Fluttertoast.showToast(msg: "Unauthorized task List!");
      return [];
    }
  }
}