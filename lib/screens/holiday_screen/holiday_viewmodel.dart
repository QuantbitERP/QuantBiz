import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../model/holiday_model.dart';
import '../../services/holiday_services.dart';

class Holidayviewmodel extends BaseViewModel {
  final List<int> _availableYears = [2022, 2023, 2024, 2025, 2026, 2027];
  int? _selectedYear;

  List<HolidayList> get holidaylist => _holidaylist;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  List<HolidayList> _holidaylist = [];

  initialise(BuildContext context) async {
    setBusy(true);
    _holidaylist = await fetchHolidaysForCurrentYear();
    notifyListeners();
    setBusy(false);
  }

  Future<List<HolidayList>> fetchHolidaysForCurrentYear() async {
    _selectedYear = DateTime.now().year;
    List<HolidayList> holidays =
        await HolidayServices().fetchHoliday(_selectedYear.toString());
    return holidays
        .where((holiday) => holiday.year == _selectedYear.toString())
        .toList();
  }

  void updateSelectedYear(int? year) {
    // Update the selected year and fetch holidays for the selected year
    _selectedYear = year;
    fetchHolidaysForSelectedYear();
    notifyListeners();
  }

  Future<void> fetchHolidaysForSelectedYear() async {
    if (_selectedYear != null) {
      _holidaylist =
          await HolidayServices().fetchHoliday(_selectedYear.toString());
      notifyListeners();
    }
  }
}
