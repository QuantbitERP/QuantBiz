import 'package:dio/dio.dart';
import 'package:geolocation/constants.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/timesheet_model.dart';

class TimesheetViewModel extends BaseViewModel {
  List<TimesheetDetails> _timesheets = [];
  List<TimesheetDetails> get timesheets => _timesheets;

  // Add properties for month and year
  String? selectedMonth;
  int? selectedYear;


  Future<void> fetchTimesheets({String? month, int? year}) async {
    setBusy(true);  // Set loading state

    // Get the current date
    DateTime now = DateTime.now();
    // Use current month and year if not provided
    month ??= DateFormat.MMMM().format(now); // Get the full month name
    year ??= now.year; // Get the current year

    var token = await getTocken();
    var headers = {
      'Authorization': token,
    };

    var dio = Dio();

    try {
      // Convert month name to its corresponding number
      int? monthNumber = _getMonthNumber(month);

      // Construct query parameters based on month and year
      final queryParameters = <String, dynamic>{};
      if (monthNumber != null) queryParameters['month'] = monthNumber;  // Use month number
      if (year != null) queryParameters['year'] = year;

      print('Fetching timesheets for month: $monthNumber, year: $year');

      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.get_timesheet_list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        queryParameters: queryParameters,  // Add query parameters to the request
      );

      if (response.statusCode == 200) {
        var data = response.data['data'];  // Assuming response data contains a 'data' key with timesheet list
        _timesheets = (data as List).map((json) => TimesheetDetails.fromJson(json)).toList();
      } else {
        print('Failed to fetch timesheets: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }

    setBusy(false);  // Set state back to not loading
  }



  // New method to fetch timesheets with selected month and year
  void fetchTimesheetsByMonthAndYear(String? month, int? year) {
    selectedMonth = month;
    selectedYear = year;
    fetchTimesheets(month: month, year: year);
  }

  // Helper method to convert month name to number
  int? _getMonthNumber(String? month) {
    const monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    return month != null ? monthMap[month] : null;
  }
}
