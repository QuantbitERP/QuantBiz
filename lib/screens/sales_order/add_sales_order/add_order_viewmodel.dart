import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/model/order_details_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_order_model.dart';
import '../../../model/search_order_model.dart';
import '../../../services/add_order_services.dart';
import 'package:intl/intl.dart';

class AddOrderViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selecteddeliveryDate;
  List<String> searchcutomer = [""];
  List<SearchCustomerList> cutomer = [];
  List<String> warehouse = [""];
  List<Items> selectedItems = [];
  List<OrderDetailsModel> orderetails = [];
String displayString='';
  // int quantity= 0;
  String name="";
  bool res = false;
  bool isEdit = false;
  bool isloading = false;
  bool isSame = false;
  List<String> ordetype = ["Sales", "Maintenance", "Shopping Cart"];
  TextEditingController customercontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController deliverydatecontroller = TextEditingController();
  late String orderId;

  AddOrderModel orderdata = AddOrderModel();

  initialise(BuildContext context, String orderid) async {
    setBusy(true);
    searchcutomer = await AddOrderServices().fetchcustomer();
    warehouse = await AddOrderServices().fetchwarehouse();
    // cutomer=await AddOrderServices().fetcustomer();
    orderId = orderid;
    orderStatus=0;
    //setting aleardy available data
    if (orderId != "") {
      orderdata.items?.clear();
      // selectedItems.clear();
      isEdit = true;
      orderdata = await AddOrderServices().getOrder(orderid) ?? AddOrderModel();
      isSame=true;
      customercontroller.text = orderdata.customer ?? "";
      orderStatus=orderdata.docstatus;
      deliverydatecontroller.text = orderdata.deliveryDate ?? "";
      selectedItems.addAll(orderdata.items?.toList() ?? []);

    }
    orderdata.orderType = "Sales";
    updateTextFieldValue();
    setBusy(false);
    notifyListeners();

  }


  void onSavePressed(BuildContext context) async {
    if (orderStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot edit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
    setBusy(true);

    if (formKey.currentState!.validate()) {
      orderdata.items = selectedItems;

      if (isEdit) {
        handleEdit(context);
      } else {
        handleNonEdit(context);
      }
    }

    setBusy(false);
  }

  void handleEdit(BuildContext context) async {
    name = await AddOrderServices().addOrder(orderdata);
    if (name.isNotEmpty) {
      isSame = true;
setBusy(false);
    }
  }

  void handleNonEdit(BuildContext context) async {
    name = await AddOrderServices().addOrder(orderdata);
    if (name.isNotEmpty) {

      initialise(context, name);

    }
  }


 Future<void> onSubmitPressed(BuildContext context) async {
  if (orderStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot submit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }

  setBusy(true);
  if (formKey.currentState!.validate()) {

    orderdata.items = selectedItems;
    orderdata.docstatus = 1;
    bool res = false;
    Logger().i(orderdata.toJson());

    res = await AddOrderServices().updateOrder(orderdata);
    if (res) {
      if (context.mounted) {
        setBusy(false);
        Navigator.pop(context);
      }
    }
  }
  setBusy(false);
}

  void onCancelPressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      orderdata.items = selectedItems;
      orderdata.docstatus = 2;
      bool res = false;
      Logger().i(orderdata.toJson());

      res = await AddOrderServices().cancelOrder(orderdata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        }
      }

    }
    setBusy(false);
  }


  ///dates functions///
  void updateTextFieldValue() {
    final selectedItemsValue = selectedItems.isEmpty
        ?'Items are not selected'
        : '${selectedItems.length} items are selected';
    displayString = selectedItemsValue;
    notifyListeners();
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
      isSame=false;
      deliverydatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      orderdata.deliveryDate = deliverydatecontroller.text;
    }
    notifyListeners();
  }

  ///setvalues//

  void ondeliveryDobChanged(String value) {
    isSame=false;
    orderdata.deliveryDate = value;
  }

  void setcustomer(String? customer) {
    isSame=false;
    orderdata.customer = customer;
    notifyListeners();
  }

  void setordertype(String? ordertype) {
    isSame=false;
    orderdata.orderType = ordertype;
    notifyListeners();
  }

  void setwarehouse(String? setWarehouse) {
    isSame=false;
    orderdata.setWarehouse = setWarehouse;
    notifyListeners();
  }



  void setSelectedItems(List<Items> SelectedItems) async {
    isSame=false;
    selectedItems = SelectedItems;
    for (var item in selectedItems) {
      item.warehouse = orderdata.setWarehouse;
      item.deliveryDate = orderdata.deliveryDate;
      item.amount = (item.qty ?? 1.0) * (item.rate ?? 0.0);
    }
    orderdata.items = selectedItems;
    updateTextFieldValue();
    Logger().i(orderdata.toJson());
    orderdetails(await AddOrderServices().orderdetails(orderdata));
    notifyListeners();
  }


  void orderdetails(List<OrderDetailsModel> orderdetail) {
    isSame=false;
    orderdata.totalTaxesAndCharges =
        orderdetail.isNotEmpty ? orderdetail[0].totalTaxesAndCharges : 0.0;
    orderdata.grandTotal =
        orderdetail.isNotEmpty ? orderdetail[0].grandTotal : 0.0;
    orderdata.discountAmount =
        orderdetail.isNotEmpty ? orderdetail[0].discountAmount : 0.0;
    orderdata.total = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
    orderdata.netTotal = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    isSame=false;
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          (selectedItems[index].qty ?? 0.0) + quantityChange.toDouble();
      selectedItems[index].amount = (selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0);
      orderdetails(await AddOrderServices().orderdetails(orderdata));
    }
    notifyListeners();
  }

  double getQuantity(Items item) {
    return item.qty ?? 1.0;
  }

  void additem(int index) async {
    isSame=false;
    updateItemQuantity(index, 1);
    notifyListeners();
  }

  void removeitem(int index) async {
    isSame=false;
    updateItemQuantity(index, -1);
    notifyListeners();
  }

  void deleteitem(int index) async {
    isSame=false;
   selectedItems.removeAt(index);
   orderdata.items = selectedItems;
   orderdetails(await AddOrderServices().orderdetails(orderdata));
   updateTextFieldValue();
    notifyListeners();
   Logger().i(selectedItems.length);
  }



  ///validators////
  String? validatewarehouse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Source warehouse';
    }
    return null;
  }

  String? validatedeliveryDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Delivery Date';
    }
    return null;
  }

  String? validateordertype(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Order Type';
    }
    return null;
  }

  @override
  void dispose() {
    customercontroller.dispose();
    deliverydatecontroller.dispose();
    super.dispose();
  }
}
