import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/customer_list_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../services/customer_list_services.dart';


class CustomerListViewModel extends BaseViewModel{

List<CustomerList> customerList=[];
List<CustomerList> filterCustomerList=[];
List<String> customerShowList=[];
List<String> territoryList=[];
  Future<void> initialise(BuildContext context) async {
setBusy(true);
customerList=await CustomerListService().fetchCustomerList();
customerShowList=await CustomerListService().getcustomer();
territoryList=await CustomerListService().fetchterritory();
filterCustomerList=customerList;
setBusy(false);
  }

Future<void> refresh() async {
  filterCustomerList=await CustomerListService().fetchCustomerList();
  notifyListeners();
}
void onRowClick(BuildContext context, CustomerList? cusList) {
  Navigator.pushNamed(
    context,
    Routes.updateCustomer,
    arguments: UpdateCustomerArguments(id: cusList?.name ?? ""),

  );
}

String? custm;
String? territory;

void setcustomer(String? customer) {
  custm = customer ?? "";
  notifyListeners();
}

void setqterritory(String? quotation) {
  territory = quotation ?? "";
  notifyListeners();
}

void setfilter(String territory,String customer) async {
  filterCustomerList= await CustomerListService().fetchFilterCustomer(territory, customer);
  notifyListeners();
}

void clearfilter() async {
  territory="";
  custm="";
  filterCustomerList=await CustomerListService().fetchCustomerList();
  notifyListeners();
}
}