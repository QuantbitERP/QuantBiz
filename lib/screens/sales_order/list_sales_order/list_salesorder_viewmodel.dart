import 'package:flutter/material.dart';
import 'package:geolocation/services/add_order_services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/order_list_model.dart';
import '../../../router.router.dart';
import '../../../services/order_services.dart';

class ListOrderModel extends BaseViewModel {
  List<OrderList> orderlist = [];
  List<OrderList> filterorderlist = [];
  List<String> searchcutomer = [""];


  initialise(BuildContext context) async {
    setBusy(true);
    orderlist = await OrderServices().fetchsalesorder();
    searchcutomer = await AddOrderServices().fetchcustomer();
   filterorderlist=orderlist;

    setBusy(false);
  }

  void onRowClick(BuildContext context, OrderList? farmresList) {
    Navigator.pushNamed(
      context,
      Routes.addOrderScreen,
      arguments: AddOrderScreenArguments(orderid: farmresList?.name ?? ""),
    );
  }
   DateTime? selecteddeliveryDate;

 Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      date = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

Future<void> refresh() async {
  filterorderlist= await OrderServices().fetchsalesorder();
  notifyListeners();
}

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Draft':
        return Colors.grey[400] ??
            Colors.grey; // Set the color for Draft status
      case 'On Hold':
        return Colors.orangeAccent; // Set the color for On Hold status
      case 'To Deliver and Bill':
        return Colors.orange; // Set the color for To Deliver and Bill status
      case 'To Bill':
        return Colors.orange; // Set the color for To Bill status
      case 'To Deliver':
        return Colors.orange; // Set the color for To Deliver status
      case 'Completed':
        return Colors.green; // Set the color for Completed status
      case 'Cancelled':
        return Colors.red; // Set the color for Cancelled status
      case 'Closed':
        return Colors.green; // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }

 String? custm;
String? date;

  void setcustomer(String? customer) {
  custm = customer ?? "";
    notifyListeners();
  }

  void setfilter(String customer,String date) async {

   filterorderlist= await OrderServices().filterfetchSalesOrder(customer, date);
   notifyListeners();
  }

  void clearfilter() async {
 date="";
   custm="";
    filterorderlist= await OrderServices().fetchsalesorder();
    notifyListeners();
  }

}
