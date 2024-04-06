import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/model/notes_list.dart';
import 'package:logger/logger.dart';

class UpdateLeadServices{


    Future<List<NotesList>> getnotes(String leadname) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_data_from_notes',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<NotesList> caneList = List.from(jsonData['data'])
            .map<NotesList>((data) => NotesList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO get notes!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["exception"].toString());
    }
    return [];
  }


  
    Future<bool> deletenotes(String leadname,int index) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname,'row_id':index.toString()};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.delete_note_in_lead',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
   
   Logger().i(response.data["data"].toString());
   Fluttertoast.showToast(msg: response.data["message"].toString());
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO delete notes!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  
    Future<bool> addnotes(String leadname,dynamic note) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname,'note':note};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.add_note_in_lead',
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

   Future<bool> changestatus(String leadname,String type) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname,'type':type};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.change_status',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
   Logger().i(response.data["message"].toString());
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO change status!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }
}