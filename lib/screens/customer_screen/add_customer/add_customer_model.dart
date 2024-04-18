import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:geolocation/services/add_customer_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AddCustomerViewModel extends BaseViewModel{
  final formKey = GlobalKey<FormState>();
CreateCustomer customerData=CreateCustomer();
List<String> territoryList=[];
List<String> groupList=[];
List<String> typeList=["Company",
  "Individual",
  "Proprietorship",
  "Partnership"];

  List<String> gstCategory=["Registered Regular",
    "Registered Composition",
    "Unregistered",
    "SEZ",
    "Overseas",
    "Deemed Export",
    "UIN Holders",
    "Tax Deductor"];
  Shipping shipping= Shipping(); Billing billing= Billing();
TextEditingController customerName=TextEditingController();
  TextEditingController mobileNumber=TextEditingController();
  TextEditingController emailId=TextEditingController();
  TextEditingController gstIn=TextEditingController();
bool isEdit=false;


  initialise(BuildContext context,String customerId)async{
    setBusy(true);
    groupList=await AddCustomerServices().fetchCustomerGroup();
    territoryList=await AddCustomerServices().fetchTerritory();
    customerData.gstCategory="Unregistered";
    customerData.customerType="Company";
    if(customerId != "") {
      isEdit = true;
      customerData = await AddCustomerServices().getCustomer(customerId) ??
          CreateCustomer();
      customerName.text = customerData.customerName ?? "";
      mobileNumber.text = customerData.mobileNo ?? "";
      emailId.text = customerData.emailId ?? "";
      gstIn.text = customerData.gstin ?? "";
      billing=customerData.billing ?? Billing();
      shipping=customerData.shipping ?? Shipping();
      Logger().i(customerData.toJson());

    }

    setBusy(false);
  }

void onSavePressed(BuildContext context) async {
  if (billing.country ==null && shipping.country== null) {
    Fluttertoast.showToast(
      msg: 'Please enter the address',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
  setBusy(true);

  if (formKey.currentState!.validate()) {
    customerData.billing=billing;
    customerData.shipping=shipping;
    Logger().i(customerData.toJson());
    print(customerData.toJson());
    bool res = false;
    if(isEdit==true){
      res = await AddCustomerServices().createCustomer(customerData);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        }}
    }
    else{
    res = await AddCustomerServices().createCustomer(customerData);
    if (res) {
      if (context.mounted) {
        setBusy(false);
        Navigator.pop(context);
      }}
  }}
  setBusy(false);
}



void setName(String name){
  customerName.text=name;
  customerData.customerName =customerName.text;
  notifyListeners();
}

  void setMobile(String mobile){
    mobileNumber.text=mobile;
    customerData.mobileNo =mobileNumber.text;
    notifyListeners();
  }
  void setEmail(String email){
    emailId.text=email;
    customerData.emailId =emailId.text;
    notifyListeners();
  }

void setTerritory(String? territory){
  customerData.territory =territory;
  notifyListeners();
}

void setGroup(String? customerGroup){
  customerData.customerGroup =customerGroup;
  notifyListeners();
}

void setType(String? customerType){
  customerData.customerType =customerType;
  notifyListeners();
}

  void setGst(String gst){
    gstIn.text=gst;
    customerData.gstin =gstIn.text;
    notifyListeners();
  }

  void setGstCategory(String? gstCategory){

    customerData.gstCategory =gstCategory;
    notifyListeners();
  }

///validators///
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter Name';
  }
  return null;
}

String? validateGroup(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select group';
  }
  return null;
}

String? validateType(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select type';
  }
  return null;
}

String? validateTerritory(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select territory';
  }
  return null;
}

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select category';
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customerName.dispose();
    mobileNumber.dispose();
    emailId.dispose();
    gstIn.dispose();
    super.dispose();
  }
}