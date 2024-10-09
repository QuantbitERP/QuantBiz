
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/model/emp_data.dart';
import 'package:geolocation/model/employee_details.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_timesheet_model.dart';
import '../../../services/add_task_services.dart';
import '../../../services/profle_services.dart';


class AddTimeSheetViewModel extends BaseViewModel {
  String _name = '';
  String _employee = '';
  String _company = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _remarks = '';
  String _project = '';
  // List of employees and companies
  List<String> employeeList = ['John Doe', 'Jane Smith', 'Robert Brown']; // Mock data
  List<String> companyList = ['ABC Corp', 'XYZ Ltd', '123 Industries'];
  List<String> projectList =[];
  EmpData employeeData = EmpData();
  String selectedProject="";

  // List of time logs
  List<TimeLog> _timeLogs = [];
  EmployeeDetails employeeDetails= EmployeeDetails();


  // Getters
  String get name => _name;
  String get employee => _employee;
  String get company => _company;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  String get remarks => _remarks;
  String get project => _project;
  List<TimeLog> get timeLogs => _timeLogs;

  initialise(BuildContext context) async {
    setBusy(true);
    employeeDetails = await ProfileServices().profile() ?? EmployeeDetails();
    Logger().i(employeeDetails.toJson());
    projectList = await AddTaskServices().fetchProject();
    updateEmployee(employeeDetails.employeeName!);
    updateCompany(employeeDetails.company!);

    setBusy(false);
  }


  // Setters
  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateEmployee(String value) {
    _employee = value;
    notifyListeners();
  }

  void updateCompany(String value) {
    _company = value;
    notifyListeners();
  }

  void updateStartDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  void updateEndDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  void updateProject(String value) {
    _project = value;
    selectedProject = value;
    notifyListeners();
  }

  void updateRemarks(String value) {
    _remarks = value;
    notifyListeners();
  }

  void addTimeLog(TimeLog timeLog) {
    _timeLogs.add(timeLog);
    notifyListeners();
  }


  void submitForm() async {
    // Check if required fields are filled
    // if (_name.isEmpty || _employee.isEmpty || _company.isEmpty || _timeLogs.isEmpty) {
    //   // Handle the case where required fields are not filled
    //   print('Please fill all required fields.');
    //   return;
    // }

    // Prepare the data to be sent
    Map<String, dynamic> data = {
      'name': _name,
      'employee': employeeDetails.name,
      'company': _company,
      'start_date': _startDate.toIso8601String(),
      'end_date': _endDate.toIso8601String(),
      'remarks': _remarks,
      'time_logs': _timeLogs.map((log) => log.toJson()).toList(), // Convert TimeLog objects to JSON
    };

    print(jsonEncode(data));

    // Prepare headers, if necessary
    Map<String, dynamic> headers = {
      'Authorization': await getTocken(), // Replace with your token
      'Content-Type': 'application/json',
    };

    // Call the createTimesheet method
    await createTimesheet(data, headers);
  }

  Future<void> createTimesheet(Map<String, dynamic> data, Map<String, dynamic> headers) async {
    try {
      var response = await Dio().request(
        'https://mobilecrm.erpdata.in/api/method/mobile.mobile_env.timesheet.create_timesheet',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print('Success: ${json.encode(response.data)}');
        // You can handle the successful response here, e.g., navigate to another page
      } else {
        print('Error: ${response.statusMessage}');
        // Handle error response
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exceptions, such as network errors
    }
  }
}
