import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../model/expenselist_model.dart';
import '../../../services/list_expense_services.dart';


class  ExpenseViewModel extends BaseViewModel{
List<Expenselist> _expenselist=[];
  final List<int> _availableYears = [2022,2023,2024,2025,2026,2027];
  int? _selectedYear;
  int? _selectedmonth;
String? monthname;

  List<Expenselist> get expenselist => _expenselist;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  int? get selectedMonth => _selectedmonth;

  initialise(BuildContext context) async {
    setBusy(true);
    _expenselist=await fetchHolidaysForCurrentYear();
    notifyListeners();
    setBusy(false);
  }
Future<void> refresh() async {
  _expenselist=await fetchHolidaysForCurrentYear();
  notifyListeners();
}

IconData getIconForStatus(String status) {
  switch (status) {
    case 'Draft':
      return
        Icons.drafts; // Set the color for Draft status// Set the color for On Hold status
    case 'Rejected':
      return Icons.close; // Set the color for To Deliver and Bill status
  // Set the color for To Deliver status
    case 'Approved':
      return Icons.check; // Set the color for Completed status
// Set the color for Closed status
    default:
      return Icons.drafts; // Set a default color for unknown status
  }
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'Draft':
      return
          Colors
              .grey; // Set the color for Draft status// Set the color for On Hold status
    case 'Rejected':
      return Colors.redAccent; // Set the color for To Deliver and Bill status
  // Set the color for To Deliver status
    case 'Approved':
      return Colors.green; // Set the color for Completed status
// Set the color for Closed status
    default:
      return Colors.black87; // Set a default color for unknown status
  }
}
  Future<List<Expenselist>> fetchHolidaysForCurrentYear() async {
    _selectedYear = DateTime.now().year.toInt();
    _selectedmonth=DateTime.now().month;
    List<Expenselist> holidays = await ExpenseServices().fetchexpense(_selectedmonth!,_selectedYear!);
    return holidays;
  }

  void updateSelectedYear(int? year) {
    // Update the selected year and fetch holidays for the selected year
    _selectedYear = year;
    fetchHolidaysForSelectedYear();
    notifyListeners();
  }

  void updateSelectedmonth(int month) {
    // Update the selected year and fetch holidays for the selected year
    _selectedmonth = month;
     monthname= getMonthName(month);
    fetchHolidaysForSelectedYear();
    notifyListeners();
  }

  Future<void> fetchHolidaysForSelectedYear() async {
    if (_selectedYear != null && _selectedmonth != null) {
      _expenselist =  await ExpenseServices().fetchexpense(_selectedmonth!,_selectedYear!);
      notifyListeners();
    }
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