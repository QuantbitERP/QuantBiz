import 'package:dio/dio.dart';
import 'package:geolocation/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../model/timesheet_model.dart';


class TimesheetViewModel extends BaseViewModel {


  List<TimesheetDetails> _timesheets = [];

  List<TimesheetDetails> get timesheets => _timesheets;

  Future<void> fetchTimesheets() async {
       setBusy(true);  // Set loading state
       var token = await getTocken();
       var headers = {
          'Authorization': token,
       };

        var dio = Dio();

      try {
         var response = await dio.request(
          'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.get_timesheet_list',
           options: Options(
             method: 'GET',
             headers: headers,
           ),
      );

    if (response.statusCode == 200) {
      var data = response.data['data'];  // Assuming response data contains a 'message' key with timesheet list
     _timesheets = (data as List).map((json) => TimesheetDetails.fromJson(json)).toList();
      print('Timesheets fetched: ${_timesheets.length}'); // Optional: For debugging
  } else {
       print('Failed to fetch timesheets: ${response.statusMessage}');
     }
  } catch (e) {
       print('Error: $e');
  }

    setBusy(false);  // Set state back to not loading
  }


}
