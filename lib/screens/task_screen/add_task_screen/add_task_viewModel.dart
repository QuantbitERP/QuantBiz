import 'package:flutter/material.dart';
import 'package:geolocation/services/add_task_services.dart';
import 'package:stacked/stacked.dart';

class AddTaskViewModel extends BaseViewModel{

  var subject = TextEditingController();
  var description = TextEditingController();
  String statusValueChoose = 'Open';
  String priorityValueChoose = 'Low';
  String? project;
  String? type;
  String? parentTask;
  List<String> projectList = [];
  List<String> typeList = [];
  List<String> parentTaskList = [];

  List statusItem = [
    "Open",
    "Working",
    "Pending Review",
    "Overdue",
    "Template",
    "Completed",
    "Cancelled"
  ];

  List priorityItem = ["Low", "Medium", "High", "Urgent"];

  initialise(BuildContext context) async {
    setBusy(true);
    projectList = await AddTaskServices().fetchProject();
    typeList = await AddTaskServices().fetchType();
    parentTaskList = await AddTaskServices().fetchParentTask();
    setBusy(false);
  }

}