import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/order_details_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/add_invoice_model.dart';
import '../../../router.router.dart';
import '../../../services/add_invoice_services.dart';
import 'package:intl/intl.dart';

class AddInvoiceViewModel extends BaseViewModel {

  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selecteddeliveryDate;
  List<String> searchcutomer = [""];
  List<String> warehouse = [""];
  List<InvoiceItems> selectedItems = [];
  List<OrderDetailsModel> orderetails = [];
  String displayString='';
  // int quantity= 0;
  bool res = false;
  bool isEdit = false;
  bool isloading = false;
  bool isSame=false;
  bool updateStock=false;
  String name="";
  TextEditingController customercontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController deliverydatecontroller = TextEditingController();
  late String orderId;

  AddInvoiceModel invoiceData = AddInvoiceModel();

  initialise(BuildContext context, String orderid) async {
    setBusy(true);
    searchcutomer = await AddInvoiceServices().fetchcustomer();
    warehouse = await AddInvoiceServices().fetchwarehouse();
    orderId = orderid;
    invoiceStatus=0;
    //setting aleardy available data
    if (orderId != "") {
      invoiceData.items?.clear();
      isEdit = true;
      invoiceData = await AddInvoiceServices().getOrder(orderid) ?? AddInvoiceModel();
      if(invoiceData==invoiceData){
        isSame=true;
      }
      invoiceStatus=invoiceData.docstatus;
      updateStock=invoiceData.updateStock ==1 ?true :false;
      customercontroller.text = invoiceData.customer ?? "";
      deliverydatecontroller.text = invoiceData.dueDate ?? "";
      selectedItems.addAll(invoiceData.items?.toList() ?? []);

      Logger().i(invoiceData.toJson());
    }
    updateTextFieldValue();
    notifyListeners();
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    Logger().i(invoiceStatus);
  if (invoiceStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot edit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      invoiceData.items = selectedItems;
      if (isEdit) {
        handleEdit(context);
      } else {
        handleNonEdit(context);
      }
    }
    setBusy(false);
  }

  void handleEdit(BuildContext context) async {
    name = await AddInvoiceServices().addInvoice(invoiceData);

    if (name.isNotEmpty) {
      isSame = true;

    }
  }

  void handleNonEdit(BuildContext context) async {
    name = await AddInvoiceServices().addInvoice(invoiceData);

    if (name.isNotEmpty) {
      initialise(context, name);
    }
  }



  void onSubmitPressed(BuildContext context) async {
    Logger().i(invoiceStatus);
      if (invoiceStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot submit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      invoiceData.items = selectedItems;
      invoiceData.docstatus=1;
      bool res=false;
      Logger().i(invoiceData.toJson());

      res = await AddInvoiceServices().updateOrder(invoiceData);
      if (res) {
        if (context.mounted) {
          setBusy(false);
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
      invoiceData.items = selectedItems;
      invoiceData.docstatus=2;
      bool res=false;
      Logger().i(invoiceData.toJson());

      res = await AddInvoiceServices().cancelInvoice(invoiceData);
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
      invoiceData.dueDate = deliverydatecontroller.text;
    }
    notifyListeners();
  }

  ///setvalues//

  void ondeliveryDobChanged(String value) {
    isSame=false;
    invoiceData.dueDate = value;
  }

  void setcustomer(String? customer) {
    isSame=false;
    invoiceData.customer = customer;
    notifyListeners();
  }

  void setStock(bool? customer) {
    isSame=false;
    updateStock=customer ??false;
    invoiceData.updateStock = updateStock ?1:0;
    notifyListeners();
  }

  void setwarehouse(String? setWarehouse) {
    isSame=false;
    invoiceData.setWarehouse = setWarehouse;
    notifyListeners();
  }

  void setSelectedItems(List<InvoiceItems> SelectedItems) async {
    isSame=false;
    selectedItems = SelectedItems;
    for (var item in selectedItems) {
      Logger().i(item.qty);
      item.amount = (item.qty ?? 1.0) * (item.rate ?? 0.0);
    }
    invoiceData.items = selectedItems;
    updateTextFieldValue();
    Logger().i(invoiceData.toJson());
    orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
    notifyListeners();
  }


  void orderdetails(List<OrderDetailsModel> orderdetail) {
    isSame=false;
    Logger().i('edited');
    invoiceData.totalTaxesAndCharges =
    orderdetail.isNotEmpty ? orderdetail[0].totalTaxesAndCharges : 0.0;
    invoiceData.grandTotal =
    orderdetail.isNotEmpty ? orderdetail[0].grandTotal : 0.0;
    invoiceData.discountAmount =
    orderdetail.isNotEmpty ? orderdetail[0].discountAmount : 0.0;
    invoiceData.total = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
    invoiceData.netTotal = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    isSame=false;
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          (selectedItems[index].qty ?? 0.0) + quantityChange.toDouble();
      selectedItems[index].amount = (selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0);
      orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
    }
    notifyListeners();
  }

  double getQuantity(InvoiceItems item) {
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
    invoiceData.items = selectedItems;
    orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
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
