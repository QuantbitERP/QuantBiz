
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/model/add_task_model.dart';
import 'package:geolocation/model/emp_data.dart';
import 'package:geolocation/model/employee_details.dart';
import 'package:geolocation/services/timesheet_services.dart';
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
  List<Project> projectList =[];
  EmpData employeeData = EmpData();
  Project? selectedProject;

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

  initialise(BuildContext context,String id) async {
    setBusy(true);
    employeeDetails = await ProfileServices().profile() ?? EmployeeDetails();
    Logger().i(employeeDetails.toJson());
    projectList = await AddTaskServices().fetchProject();
    updateEmployee(employeeDetails.employeeName!);
    updateCompany(employeeDetails.company!);

    if (id != "") {
      var timesheetDetails = await TimesheetServices().getTimesheetDetails(id) ;
      if(timesheetDetails != null) {
      //  _timeLogs = (timesheetDetails.timeLogs as List<TimeLog>) ?? [];
         for(var timesheet in timesheetDetails.timeLogs!){
           _timeLogs.add(TimeLog(activityType: timesheet.activityType!,
               task: timesheet.task!, hours: timesheet.hours!.toDouble(),
               fromTime: DateTime.parse(timesheet.fromTime!),
               toTime: DateTime.parse(timesheet.toTime!),
               project: timesheet.project!,
               description: timesheet.description!));
         }
       //  updateProject(timesheetDetails.parentProject!);
        _project = timesheetDetails.parentProject!;
        _name = timesheetDetails.name!;
        _employee = timesheetDetails.employeeName!;
        _company = timesheetDetails.company!;
        _startDate = DateTime.parse(timesheetDetails.startDate!);
        _endDate = DateTime.parse(timesheetDetails.endDate!);
        selectedProject = projectList.firstWhere(
                 (project) => project.name == timesheetDetails.parentProject
         );
      }


    }

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

  void updateProject(Project value) {
    _project = value.name;
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
  void updateTimeLog(int index, TimeLog updatedTimeLog) {
    if (index >= 0 && index < _timeLogs.length) {
      _timeLogs[index] = updatedTimeLog; // Update the specific time log
      notifyListeners(); // Notify listeners about the change
    } else {
      // Optionally handle invalid index case
      print("Invalid index for updating TimeLog");
    }
  }


  void submitForm(BuildContext context) async {
   // Check if required fields are filled
   //  if (_name.isEmpty || _employee.isEmpty || _company.isEmpty || _timeLogs.isEmpty) {
   //    // Handle the case where required fields are not filled
   //    print('Please fill all required fields.');
   //    Fluttertoast.showToast(msg: "Please fill all required details.");
   //    return;
   //  }

    // Prepare the data to be sent
    Map<String, dynamic> data = {
      'name': _name,
      'employee': employeeDetails.name,
      'company': _company,
      'start_date': _startDate.toIso8601String(),
      'end_date': _endDate.toIso8601String(),
      'remarks': _remarks,
      'project':_project,
      'time_logs': _timeLogs.map((log) => log.toJson()).toList(), // Convert TimeLog objects to JSON
    };

    print(jsonEncode(data));

    // Prepare headers, if necessary
    Map<String, dynamic> headers = {
      'Authorization': await getTocken(), // Replace with your token
      'Content-Type': 'application/json',
    };

    // Call the createTimesheet method
    bool result = await TimesheetServices().createTimesheet(data, headers,context);
    if(result){
      Navigator.pop(context,true);
    }
  }

  void removeTimeLog(int index) {
    if (index >= 0 && index < timeLogs.length) {
      timeLogs.removeAt(index);
      // Notify listeners if you're using ChangeNotifier or a similar pattern
      notifyListeners(); // Uncomment if using ChangeNotifier
    }
  }


}
