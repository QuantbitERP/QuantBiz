import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/add_task_model.dart';
import 'package:geolocation/model/list_task_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class AddTaskServices{

  Future<bool> addComment(String name,dynamic note) async {
    baseurl =  await geturl();

    var data = {
      "reference_doctype":"Task",
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

  Future<bool> changeStatus(String? name,String? status) async {
    baseurl =  await geturl();

    var data = {
      'task_id': name,'new_status':status};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.task.update_task_status',
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
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["message"].toString());
    }
    return false;
  }

  Future<List<Project>> fetchProject() async {
    baseurl = await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Project?fields=["name","project_name"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        // Convert the list of dynamic items into a list of Project objects
        List<Project> projectList = dataList.map((item) {
          return Project.fromJson(item);
        }).toList();

        return projectList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch projects");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data?["exception"] ?? e.message}',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );
      return [];
    }
  }

  Future<List<String>> fetchUser() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/User',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }

  fetchParentTask() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }
  Future<List<TaskList>> fetchTaskList() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task?fields=["subject","status","name","priority","exp_end_date"]',
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
        // Fluttertoast.showToast(msg: jsonData['message']);
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }

  Future<bool> addTask(AddTaskModel taskData) async {
    try {
      baseurl = await geturl();
      var data = json.encode(taskData);

      var dio = Dio();
      var response = await dio.post(
        '$baseurl/api/method/mobile.mobile_env.task.create_task',
        options: Options(
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());

        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Order!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data['message'].toString());
      return false;
    }
  }

  Future<AddTaskModel?> getTask(String id) async {
    baseurl =  await geturl();
    var data={"task_id":id};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.task.get_task_by_id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
      );

      if (response.statusCode == 200) {
        // Logger().i(AddQuotation.fromJson(response.data["data"]));
        return AddTaskModel.fromJson(response.data["data"]);
      } else {

        return null;
      }
    } on DioException catch (e) {
      Logger().i(e.response?.data['message'].toString());
      Fluttertoast.showToast(msg: "Error while fetching user");
    }
    return null;
  }
}