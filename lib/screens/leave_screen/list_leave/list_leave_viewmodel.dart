import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/leave_list.dart';
import '../../../services/list_leave_services.dart';


class  LeaveViewModel extends BaseViewModel{
List<LeaveList> _upcomingleavelist=[];
List<LeaveList> _takenleavelist=[];
  final List<int> _availableYears = [2022,2023,2024,2025,2026,2027];
  int? _selectedYear;
  int? _selectedmonth;

  List<LeaveList> get leavelist => _upcomingleavelist;
List<LeaveList> get takenlist => _takenleavelist;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  int? get selectedMonth => _selectedmonth;

  initialise(BuildContext context) async {
    setBusy(true);
    _upcomingleavelist=await fetchupcomingleaveForCurrentYear();
    _takenleavelist=await fetchTakenLeaveForCurrentYear();
    Logger().i(_takenleavelist);
    notifyListeners();
    setBusy(false);
  }

Future<void> refresh() async {
  _upcomingleavelist=await fetchupcomingleaveForCurrentYear();
  _takenleavelist=await fetchTakenLeaveForCurrentYear();
  notifyListeners();
}
  Future<List<LeaveList>> fetchupcomingleaveForCurrentYear() async {
    _selectedYear = DateTime.now().year.toInt();
    _selectedmonth=DateTime.now().month;
    List<LeaveList> holidays = await ListLeaveServices().fetchLeaves();
    List<LeaveList> filteredLeaves = holidays.where((leave) {
      DateTime? postingDate = DateTime.parse(leave.postingDate ?? ""); // Assuming postingDate is a String
      Logger().i(leave.postingDate);
      return postingDate.year == _selectedYear && postingDate.month == _selectedmonth;
    }).toList();

    return filteredLeaves;
  }


Color getColorForStatus(String status) {
  switch (status) {
    case 'Open':
      return
        Colors
            .grey; // Set the color for Draft status// Set the color for On Hold status
    case 'Rejected':
      return Colors.redAccent; // Set the color for To Deliver and Bill status
  // Set the color for To Deliver status
    case 'Approved':
      return Colors.green;
    case 'Cancelled':
      return Colors.red;// Set the color for Completed status
// Set the color for Closed status
    default:
      return Colors.black87; // Set a default color for unknown status
  }
}

Future<List<LeaveList>> fetchTakenLeaveForCurrentYear() async {
  // Get the current year and month
  _selectedYear = DateTime.now().year;
  _selectedmonth = DateTime.now().month;

  // Fetch all taken leaves
  List<LeaveList> allLeaves = await ListLeaveServices().fetchtakenLeaves();

  // Filter leaves for the current year and month
  List<LeaveList> filteredLeaves = allLeaves.where((leave) {
    DateTime? postingDate = DateTime.parse(leave.postingDate ?? ""); // Assuming postingDate is a String
Logger().i(leave.postingDate);
    return postingDate.year == _selectedYear && postingDate.month == _selectedmonth;
  }).toList();

  return filteredLeaves;
}


  void updateSelectedYear(int? year) {
    // Update the selected year and fetch holidays for the selected year
    _selectedYear = year;
    fetchLeavesForSelectedYearAndMonth();
    notifyListeners();
  }

  void updateSelectedmonth(int? month) {
    // Update the selected year and fetch holidays for the selected year
    _selectedmonth = month;
    fetchLeavesForSelectedYearAndMonth();
    notifyListeners();
  }

void fetchLeavesForSelectedYearAndMonth() async {
  if (_selectedYear != null && _selectedmonth != null) {
_takenleavelist=await ListLeaveServices().fetchtakenLeaves();
_upcomingleavelist=await  ListLeaveServices().fetchLeaves();
    _takenleavelist = _takenleavelist.where((leave) {
      DateTime postingDate = DateTime.parse(leave.postingDate ?? "");
      return postingDate.year == _selectedYear && postingDate.month == _selectedmonth;
    }).toList();

    _upcomingleavelist = _upcomingleavelist.where((leave) {
      DateTime postingDate = DateTime.parse(leave.postingDate ?? "");
      return postingDate.year == _selectedYear && postingDate.month == _selectedmonth;
    }).toList();
  }
  notifyListeners();
}





String getMonthName(int month) {
    // Ensure that the month is within a valid range (1 to 12)
    if (month < 1 || month > 12) {
      throw ArgumentError('Invalid month: $month');
    }
    // Create a DateTime object with the desired month and format it to get the month name
    DateTime dateTime = DateTime(2023, month, 1); // You can set any year, as it won't affect the month name
    String monthName = DateFormat('MMMM').format(dateTime);
    return monthName;
  }
}