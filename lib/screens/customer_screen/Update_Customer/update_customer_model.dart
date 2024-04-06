import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/model/comment_List_model.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:geolocation/services/update_customer_services.dart';
import 'package:stacked/stacked.dart';

import '../../../services/add_customer_services.dart';
import '../../../services/call_services.dart';

class UpdateCustomerViewModel extends BaseViewModel{
  TextEditingController comment=TextEditingController();
CreateCustomer customerData=CreateCustomer();
final CallsAndMessagesService service = CallsAndMessagesService();
List<CommentList> comments=[];
bool res=false;
List<CustOrderList> orders = [];
  List<CustOrderList> filterOrders = [];
List<String> status=[
  "Not Delivered",
  "Fully Delivered",
  "Partly Delivered",
  "Closed",
  "Not Applicable"
];
  initialise(BuildContext context,String id) async {
    setBusy(true);

if(id!=""){
  customerData = await AddCustomerServices().getCustomer(id) ??
      CreateCustomer();
  comments=await UpdateCustomerService().fetchComments(id);
  orders=await UpdateCustomerService().fetchCustomerOrder(id);
  filterOrders=orders;
}
setBusy(false);
  }

  void addComment(String? id,dynamic content)async{

    if(id!.isNotEmpty){
      res=await UpdateCustomerService().addComment(id,content);}
    if(res){
      comments=await UpdateCustomerService().fetchComments(id);
    }
    comment.clear();
    notifyListeners();
  }

  Future<void> addFilter(String id,String status) async {
    filterOrders=await UpdateCustomerService().fetchFilterCustomerOrder(id,status);
    notifyListeners();
  }
}

class CustOrderList {
  String? name;
  String? deliveryDate;
  double? roundedTotal;

  CustOrderList({this.name, this.deliveryDate, this.roundedTotal});

  CustOrderList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    deliveryDate = json['delivery_date'];
    roundedTotal = json['rounded_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['delivery_date'] = this.deliveryDate;
    data['rounded_total'] = this.roundedTotal;
    return data;
  }
}
