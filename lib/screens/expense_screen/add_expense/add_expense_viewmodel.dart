
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/expense_model.dart';
import '../../../router.router.dart';
import '../../../services/add_expense_services.dart';


class AddExpenseViewModel extends BaseViewModel{
  TextEditingController datecontroller=TextEditingController();
  TextEditingController descriptoncontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();
  DateTime? selecteddeliveryDate;
  bool delete=false;
  ExpenseData expensedata =ExpenseData();
  final formKey = GlobalKey<FormState>();
  List<String> expensetype=[""];
List<Attachments> attachment=[];

  initialise(BuildContext context) async {
    setBusy(true);
    expensetype=await AddExpenseServices().fetExpenseType();
    setBusy(false);
  }

  
  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      expensedata.attachments=attachment;
      Logger().i(expensedata.toJson());

      bool res = false;
        res = await AddExpenseServices().bookexpense(expensedata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pop(context);
          }}
    }
    setBusy(false);
  }

  Future<void> selectPdf(ImageSource source) async {
    try {
      final result = await ImagePicker().pickImage(source: source);
      if (result != null) {
        setBusy(true);
        File? compressedFile = await compressFile(fileFromXFile(result));
        Logger().i(result.path);

        Attachments? attachments = await AddExpenseServices().uploadDocs(compressedFile);

        if (attachments != null) {
          Logger().i(attachments.name);
          Logger().i(attachments.fileUrl);
          attachment.add(attachments);
        }

        setBusy(false);
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error while picking an image or document: $e',
      );
      setBusy(false);
    }
  }


  Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      datecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      expensedata.expenseDate = datecontroller.text;
    }
  }


  void setdate(String expenseDate){
    datecontroller.text=expenseDate;
    expensedata.expenseDate =datecontroller.text;
    notifyListeners();
  }

  void deleteitem(int index,String? name) async {
    attachment.removeAt(index);
    if(name != null){ delete= await AddExpenseServices().deleteDoc(name);}

    notifyListeners();
  }

  String getFileName(String path) {
    List<String> pathSegments = path.split('/');
    String lastSegment = pathSegments.last;
    return lastSegment;
  }

  void setdescription(String expenseDescription){
    descriptoncontroller.text=expenseDescription;
    expensedata.expenseDescription =descriptoncontroller.text;
    notifyListeners();
  }

  void setamount(String amount){
    amountcontroller.text=amount;
    expensedata.amount =double.tryParse(amountcontroller.text);
    notifyListeners();
  }

  void setexpensetype(String? expenseType){
    expensedata.expenseType =expenseType;
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
    datecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }
}