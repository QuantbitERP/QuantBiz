

import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/help_desk_model.dart';

class HelpDeskServices{


  Future<List<Ticket>> fetchHelpDeskDetails() async {
   var  baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.helpdesk.get_hd_tickets',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<Ticket> ticketList = List.from(jsonData['message']['tickets'])
            .map<Ticket>((data) => Ticket.fromJson(data))
            .toList();
        return ticketList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      print(e.response!.data["exception"].toString());
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
      return [];
    }
  }


}