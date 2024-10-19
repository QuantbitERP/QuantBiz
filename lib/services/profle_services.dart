import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/chane_password.dart';
import '../model/employee_details.dart';

class ProfileServices{
  Future<EmployeeDetails?> profile() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_profile',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(getTocken());
        Logger().i(response.data["data"]);
        return  EmployeeDetails.fromJson(response.data["data"]);
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO data!");
        return null;
      }
    } on DioException catch (e) {
     // Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }


  Future<bool> changepassword(ChangePassword orderdetails) async {
    baseurl =  await geturl();

    Logger().i(orderdetails.toJson().toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.change_password',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data:  orderdetails.toJson(),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Password Change successfully");
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
      Logger().e(e);
    }
    return false;
  }

  Future<String> uploadDocs(File? file) async {
    if (file == null) {
      return "";
    }
    try {
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: generateUniqueFileName(file),
        ),
      });
      var dio = Dio();
      var response = await dio.request(
        apiUploadFilePost,
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        
        Logger().i(json.encode(response.data));
        String jsonString = json.encode(response.data);
        Map<String, dynamic> jsonResponse = json.decode(jsonString);
        String fileUrl = jsonResponse["message"]["file_url"];
        return fileUrl;
      } else {
        Logger().i(response.statusMessage);
      }
    } catch (e) {
      Logger().e(e);
    }

    // Add a return statement to handle the case where the function completes normally
    return ""; // or throw an error if you prefer
  }

  Future<bool> updateProfilePicture(String fileurl) async {
    baseurl =  await geturl();
    var data = {'file_url': fileurl};
    try {
      var dio = Dio();
      var response = await dio.request(
          '$baseurl/api/method/mobile.mobile_env.app.update_profile_picture',
          options: Options(
            method: 'POST',
            headers: {'Authorization': await getTocken()},
          ),
          data: data
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message']);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch photo");
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

}