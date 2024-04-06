import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/attendance_dashboard_model.dart';
import 'package:geolocation/model/emp_data.dart';
import 'package:geolocation/model/leave_model.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/dashboard.dart';

class HomeServices {
 Future<DashBoard?> dashboard() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_dashboard',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {

        return   DashBoard.fromJson(response.data["data"]);
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO data!");
        return null;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["message"].toString());
      return null;
    }
    // return null;
  }

 Future<EmpData?> getEmpName() async {
   baseurl =  await geturl();
   try {
     var dio = Dio();
     var response = await dio.request(
       '$baseurl/api/method/mobile.mobile_env.app.get_emp_name',
       options: Options(
         method: 'GET',
         headers: {'Authorization': await getTocken()},
       ),
     );

     if (response.statusCode == 200) {

       return   EmpData.fromJson(response.data["data"]);
     } else {
       Fluttertoast.showToast(msg: "UNABLE TO data!");
       return null;
     }
   } on DioException catch (e) {
     // Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
     Logger().e(e.response?.data["message"].toString());
     return null;
   }
   // return null;
 }

    Future<bool> employeeCheckin(String logType,String location) async {
    baseurl =  await geturl();
    var data = {'log_type': logType.toString(),"location":location};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.create_employee_log',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
   // Logger().i(response.data["message"].toString());
   Fluttertoast.showToast(gravity: ToastGravity.SNACKBAR,msg: response.data["message"].toString().toUpperCase(),textColor:const Color(0xFFFFFFFF),backgroundColor: const Color.fromARGB(255, 26, 186, 29),);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Unable ot add employee log");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

 Future<List<LeaveData>> fetchleavedata() async {
   baseurl =  await geturl();
   try {
     var dio = Dio();
     var response = await dio.request(
       '$baseurl/api/method/mobile.mobile_env.app.get_leave_balance_dashboard',
       options: Options(
         method: 'GET',
         headers: {'Authorization': await getTocken()},
       ),
     );

     if (response.statusCode == 200) {
       Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
       List<LeaveData> caneList = List.from(jsonData['data']['leave_balance'])
           .map<LeaveData>((data) => LeaveData.fromJson(data))
           .toList();
       return caneList;
     } else {
       Fluttertoast.showToast(msg: "Unable to fetch orders");
       return [];
     }
   } on DioException catch (e) {
     Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
     Logger().e(e);
     return [];
   }
 }


 Future<AttendanceDashboard?> attendanceDashboard() async {
   baseurl =  await geturl();
   try {
     var dio = Dio();
     var response = await dio.request(
       '$baseurl/api/method/mobile.mobile_env.app.get_attendance_details_dashboard',
       options: Options(
         method: 'GET',
         headers: {'Authorization': await getTocken()},
       ),
     );

     if (response.statusCode == 200) {
       Logger().i(response.data["data"]);
       return   AttendanceDashboard.fromJson(response.data["data"]);
     } else {
       Fluttertoast.showToast(msg: "UNABLE TO data!");
       return null;
     }
   } on DioException catch (e) {
     Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
     Logger().e(e);
   }
   return null;
 }

 Future<List<String>> fetchRoles() async {
   baseurl =  await geturl();
   try {
     var dio = Dio();
     var response = await dio.request(
       '$baseurl/api/method/mobile.mobile_env.app.user_has_permission',
       options: Options(
         method: 'GET',
         headers: {'Authorization': await getTocken()},
       ),
     );

     if (response.statusCode == 200) {
       var jsonData = json.encode(response.data);
       Map<String, dynamic> jsonDataMap = json.decode(jsonData);
       List<dynamic> dataList = jsonDataMap["message"];
       List<String> namesList =
       dataList.map((item) => item.toString()).toList();

       return namesList;
     } else {
       Fluttertoast.showToast(msg: "Unable to fetch Customer");
       return [];
     }
   } catch (e) {
     Logger().e(e);
     Fluttertoast.showToast(msg: e.toString());
     return [];
   }
 }
}
