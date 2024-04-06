import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_leave_model.dart';
import '../../../router.router.dart';
import '../../../services/add_leave_services.dart';

class AddLeaveViewModel extends BaseViewModel{
  TextEditingController fromdatecontroller=TextEditingController();
  TextEditingController todatecontroller=TextEditingController();
  TextEditingController descriptoncontroller=TextEditingController();
  TextEditingController halfdaycontroller=TextEditingController();
  DateTime? selectedfromDate;
  DateTime? selectedtoDate;
  DateTime? selectedhalfDate;

  AddLeaveModel leavedata =AddLeaveModel();
  final formKey = GlobalKey<FormState>();
  List<String> leavetype=[""];

bool isSwitched=false;

  initialise(BuildContext context) async {
    setBusy(true);
    leavetype=await AddLeaveServices().getleavetype();
    setBusy(false);
  }

  
  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {

      Logger().i(leavedata.toJson());

      bool res = false;
        res = await AddLeaveServices().addLeave(leavedata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pop(context);
          }}
    }
    setBusy(false);
  }


  void toggleSwitch(bool value) {
    if(isSwitched == false)
    {
        isSwitched = true;
        leavedata.halfDay=1;
     notifyListeners();
      print('Switch Button is ON');
    }
    else
    {
        isSwitched = false;
        leavedata.halfDay=0;
        notifyListeners();
      print('Switch Button is OFF');
    }
  }

  Future<void> selectfromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedfromDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedfromDate) {
      selectedfromDate = picked;
      fromdatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      leavedata.fromDate = fromdatecontroller.text;
    }
  }

  Future<void> selecttoDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedtoDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedtoDate) {
      selectedtoDate = picked;
      todatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      leavedata.toDate = todatecontroller.text;
    }
  }

  Future<void> selecthalfDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedhalfDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedhalfDate) {
      selectedhalfDate = picked;
      halfdaycontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      leavedata.halfDayDate = halfdaycontroller.text;
    }
  }

  void setfromdate(String expenseDate){
    fromdatecontroller.text=expenseDate;
    leavedata.fromDate =fromdatecontroller.text;
    notifyListeners();
  }

  void settodate(String expenseDate){
    todatecontroller.text=expenseDate;
    leavedata.fromDate =todatecontroller.text;
    notifyListeners();
  }

  void sethalfdate(String expenseDate){
    halfdaycontroller.text=expenseDate;
    leavedata.halfDayDate =halfdaycontroller.text;
    notifyListeners();
  }

  void setdescription(String expenseDescription){
    descriptoncontroller.text=expenseDescription;
    leavedata.description =descriptoncontroller.text;
    notifyListeners();
  }


  void seteleavetype(String? expenseType){
    leavedata.leaveType =expenseType;
    notifyListeners();
  }

  ///validators
  String? validatedate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Select the date';
    }
    return null;
  }

  String? validateexpensetyepe(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select expense type';
    }
    return null;
  }

  String? validatedescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter description';
    }
    return null;
  }
  String? validateamount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter amount';
    }
    return null;
  }

  ///dispose controllers
  @override
  void dispose() {
    descriptoncontroller.dispose();
    fromdatecontroller.dispose();
    todatecontroller.dispose();
    halfdaycontroller.dispose();
    super.dispose();
  }
}