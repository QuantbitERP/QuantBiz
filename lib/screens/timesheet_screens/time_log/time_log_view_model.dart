// view_models/time_log_view_model.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/services/timesheet_services.dart';

import '../../../model/add_timesheet_model.dart';
import '../../../model/list_task_model.dart';
import '../../../services/list_task_service.dart';


class TimeLogViewModel extends ChangeNotifier {
  String _activityType = '';
  String _task = '';
  double _hours = 0.0;
  DateTime _fromTime = DateTime.now();
  DateTime _toTime = DateTime.now();
  String _project = '';
  String _description = '';
  List<String> activityTypes = []; // Example values
  List<String> tasks = []; // Example values
  String? selectedTask;
  List<TaskList> taskList = [];
  String get activityType => _activityType;
  String get task => _task;
  double get hours => _hours;
  DateTime get fromTime => _fromTime;
  DateTime get toTime => _toTime;
  String get project => _project;
  String get description => _description;

  initialize(BuildContext context,String s) async {
    activityTypes = await TimesheetServices().fetchActivityTypes();
    taskList= await TaskListService().fetchTask();
    tasks = getTaskNames(taskList);

    setProject(s);
  }

  List<String> getTaskNames(List<TaskList> taskList) {
    return taskList.map((task) =>task.subject!).toList();
  }

  String? getTaskIdBySelectedTask() {
    // Find the task by matching the selected task name
    TaskList? selectedTaskDetails = taskList.firstWhere(
          (task) => task.subject == selectedTask
    );

    // Return the task ID if the task was found, otherwise return null
    return selectedTaskDetails.name;
  }

  double calculateTotalHours() {
    // Calculate the difference between fromTime and toTime
    Duration duration = _toTime.difference(_fromTime);
     var hr = duration.inHours + duration.inMinutes.remainder(60) / 60.0;
     _hours =  double.parse(hr.toStringAsFixed(2));
     return _hours;
  }

  void setActivityType(String value) {
    _activityType = value;
    notifyListeners();
  }

  void setTask(String value) {
    selectedTask = value;
    _task = value;
    notifyListeners();
  }

  void setHours(String value) {
    _hours = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  void setDescription(String value) {
    _description =value;
    notifyListeners();
  }

  void setFromTime(DateTime value) {
    _fromTime = value;
    notifyListeners();
  }

  void setToTime(DateTime value) {
    _toTime = value;
    calculateTotalHours();
    notifyListeners();
  }

  void setProject(String value) {
    _project = value;
    notifyListeners();
  }

  TimeLog get timeLog => TimeLog(
    activityType: activityType,
    task: getTaskIdBySelectedTask()!,
    hours: hours,
    fromTime: fromTime,
    toTime: toTime,
    project: project,
    description: description
  );





}
