import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_task_model.dart';
import '../../../services/add_task_services.dart';

class UpdateTaskViewModel extends BaseViewModel{
  AddTaskModel taskData= AddTaskModel();
  List<Comments> comments=[];
  TextEditingController comment =TextEditingController();
  bool res=false;
  initialise(BuildContext context,String Id) async {
    setBusy(true);
    if(Id!= ""){

      taskData=await AddTaskServices().getTask(Id) ?? AddTaskModel();
      comments.addAll(taskData.comments?.toList() ?? []);
    }
    setBusy(false);
  }

  List<String> statusItem = [
    "Open",
    "Working",
    "Pending Review",
    "Overdue",
    "Template",
    "Completed",
    "Cancelled"
  ];

  Color getColorForPriority(String status) {
    switch (status) {
      case 'Low':
        return Colors.grey; // Set the color for Draft status
      case 'Medium':
        return Colors.deepOrangeAccent; // Set the color for On Hold status
      case 'High':
        return Colors.red; // Set the color for To Deliver and Bill status
      case 'Urgent':
        return Colors.redAccent.shade400; // Set the color for To Bill status
    // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }


  Color getColorForStatus(String status) {
    switch (status) {
      case 'Open':
        return Colors.brown[400] ??
            Colors.brown; // Set the color for Draft status
      case 'Working':
        return Colors.orangeAccent; // Set the color for On Hold status
      case 'Pending Review':
        return Colors.orange; // Set the color for To Deliver and Bill status
      case 'Overdue':
        return Colors.redAccent; // Set the color for To Bill status
      case 'Template':
        return Colors.blue; // Set the color for To Deliver status
      case 'Completed':
        return Colors.green; // Set the color for Completed status
      case 'Cancelled':
        return Colors.grey; // Set the color for Cancelled status
    // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }
  void addComment(String? id,dynamic content)async{

    if(id!.isNotEmpty){
      res=await AddTaskServices().addComment(id,content);}
    if(res){
      taskData=await AddTaskServices().getTask(id) ?? AddTaskModel();
      comments.addAll(taskData.comments?.toList() ?? []);
    }
    comment.clear();
    notifyListeners();
  }

  Future<void> changeStatus(BuildContext context,String? action) async {
    setBusy(true);
    bool res = false;
    //res = res=await AddTaskServices().changeStatus(taskData.name,action);
    if (res) {
    //  initialise(context,taskData.name.toString());
    }
    notifyListeners();
    setBusy(false);
  }

}