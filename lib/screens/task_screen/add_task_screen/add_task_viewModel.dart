import 'package:flutter/material.dart';
import 'package:geolocation/services/add_task_services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_task_model.dart';

class AddTaskViewModel extends BaseViewModel {
  AddTaskModel taskData = AddTaskModel();
  final formKey = GlobalKey<FormState>();
  var subject = TextEditingController();
  var description = TextEditingController();
  var endDate = TextEditingController();
  DateTime? selecteddeliveryDate;
  String statusValueChoose = 'Open';
  String priorityValueChoose = 'Low';
  String? project;
  String? type;
  String? parentTask;
  List<String> projectList = [];
  List<String> userList = [];
  List<String> parentTaskList = [];
  List<String> assignToList = [];
  bool idEdit = false;

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

  initialise(BuildContext context, String id) async {
    setBusy(true);
    projectList = await AddTaskServices().fetchProject();
    userList = await AddTaskServices().fetchUser();
    parentTaskList = await AddTaskServices().fetchParentTask();
    taskData.priority = "Low";
    taskData.status = "Open";

    if (id != "") {
      idEdit = true;
      taskData = await AddTaskServices().getTask(id) ?? AddTaskModel();
      subject.text = taskData.subject ?? "";
      description.text = taskData.description ?? "";
      endDate.text = taskData.expEndDate ?? "";
    }
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);

    if (formKey.currentState!.validate()) {
      bool res = false;
      taskData.assignedTo = assignToList;
      // if(isEdit==true){
      //   res = await AddCustomerServices().createCustomer(customerData);
      //   if (res) {
      //     if (context.mounted) {
      //       setBusy(false);
      //       Navigator.pop(context);
      //     }}
      // }
      // else{
      Logger().i(taskData.toJson());
      res = await AddTaskServices().addTask(taskData);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        }
      }
      // }
    }
    setBusy(false);
  }

  Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      endDate.text = DateFormat('yyyy-MM-dd').format(picked);
      taskData.expEndDate = endDate.text;
    }
    notifyListeners();
  }

  void changeSubject(String subjecttext) {
    subject.text = subjecttext;
    taskData.subject = subject.text;
    notifyListeners();
  }

  void changeDescription(String descriptionText) {
    description.text = descriptionText;
    taskData.description = subject.text;
    notifyListeners();
  }

  void changeStatus(String? status) {
    taskData.status = status;
    notifyListeners();
  }

  void changeParentTask(String? parentTask) {
    taskData.parentTask = parentTask;
    notifyListeners();
  }

  void changePriority(String? priority) {
    taskData.priority = priority;
    notifyListeners();
  }

  void onChanged(List<String>? newValue) {
    assignToList.addAll(newValue?.toList() ?? []);
    notifyListeners();
  }

  void changeProject(String? project) {
    taskData.project = project;
    notifyListeners();
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'is required!';
    }
    return null;
  }
}
