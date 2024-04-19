import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/dashboard.dart';
import 'package:geolocation/model/emp_data.dart';
import 'package:geolocation/services/home_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../router.router.dart';
import '../../services/geolocation_services.dart';
import '../../services/platform_repository.dart';
import '../location_tracking/tracking_service.dart';

class HomeViewModel extends BaseViewModel {
  late SharedPreferences prefs;
  DashBoard _cachedDashboard = DashBoard();
  List<String> availableDoctypes=[""];
  bool isHide = false;
  DashBoard dashboard=DashBoard();
  AttendanceDetails  attendanceDashboard=AttendanceDetails();
  List<LeaveBalance> leaveList=[];
  EmpData employeeData=EmpData();
  String? greeting;
  bool loading=false;
  final _repository = PlatformRepository();
  String colorResult = "0xFFCA2C92";

  changeColor(String color) async {
    colorResult = await _repository.changeColor(color);
    return colorResult;
  }


// Assuming isFormAvailableForDoctype is a function that checks if a form is available for a given doctype
  bool isFormAvailableForDoctype(String doctype) {
    return availableDoctypes.contains(doctype);
  }

  DashBoard get cachedDashboard => _cachedDashboard;

  Future<void> fetchDashboard() async {
    try {
      final dashboard = await HomeServices().dashboard() ?? DashBoard();
      _cachedDashboard = dashboard;
      await _saveDataToCache(dashboard);
      availableDoctypes = await _fetchAvailableDoctypes();
      if (dashboard.empName == null) {
        isHide = true;
      } else {
        isHide = false;
      }
      notifyListeners();
    } catch (e) {
      Logger().e('Error during dashboard fetch: $e');
      // Handle the error
    }
  }

  Future<void> initialize(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    setBusy(true);
    _cachedDashboard = _loadCachedData();
    employeeData= await HomeServices().getEmpName() ?? EmpData();
    availableDoctypes = await _fetchAvailableDoctypes();
    Logger().i(_loadCachedData().toJson());
    Logger().i(availableDoctypes.length);
    if (_loadCachedData().company == null) {
      await _fetchAvailableDoctypes();
      await fetchDashboard();
    }
    if (_cachedDashboard.empName == null) {
      isHide = true;
    } else {
      isHide = false;
    }
    dashboard=_cachedDashboard;
    attendanceDashboard=_cachedDashboard.attendanceDetails ?? AttendanceDetails();
    leaveList=_cachedDashboard.leaveBalance ?? [];
    handleGreeting();
    setBusy(false);
    notifyListeners();
  }

  DashBoard _loadCachedData() {
    final cachedDashboardString = prefs.getString('cached_dashboard');
    if (cachedDashboardString != null) {
      final Map<String, dynamic> cachedData = json.decode(cachedDashboardString);
      return DashBoard.fromJson(cachedData);
    }
    return DashBoard();
  }

  Future<List<String>> _fetchAvailableDoctypes() async {
    return await HomeServices().fetchRoles();
  }

  Future<void> _saveDataToCache(DashBoard newDashboard) async {
    final String jsonData = json.encode(newDashboard.toJson());
    prefs.setString('cached_dashboard', jsonData);
  }

  Future<void> handleLogout(BuildContext context) async {
    if (_cachedDashboard.company == "") {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
    }
  }

  void employeeLog(String logtype, BuildContext context) async {
    setBusy(true);
    GeolocationService geolocationService = GeolocationService();
    try {
      Position? position = await geolocationService.determinePosition();
      if (position != null) {
        String location = "${position.latitude},${position.longitude}";
        bool res = await HomeServices().employeeCheckin(logtype, location);
        if (logtype == "IN") {
          TrackingService.startTracking();
        } else {
          TrackingService.stopTracking();
        }
        Logger().i(res);
        if (res) {
          await fetchDashboard();
          await initialize(context);
          setBusy(false);
        }
      } else {
        // Failed to get location, check for permission
        var status = await Permission.location.request();
        if (status != PermissionStatus.granted) {
          throw Exception('Location permissions are denied.');

        } else {
          Fluttertoast.showToast(msg: 'Failed to get location');
          setBusy(false);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    } finally {
      setBusy(false);
    }
    notifyListeners();
  }


  void handleGreeting() {
    final now = DateTime.now();
    final timeOfDay = now.hour;
    if (timeOfDay < 12) {
      greeting = "Good Morning,";

    } else if (timeOfDay < 17) {
      greeting = "Good Afternoon,";
    } else {
      greeting = "Good Evening,";

    }
  }

  Future<void> onRefresh(BuildContext context) async {
    setBusy(true);
    await fetchDashboard();
    handleGreeting();
    await initialize(context);
    setBusy(false);
  }
}
