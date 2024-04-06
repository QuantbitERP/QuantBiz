
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/addquotation_model.dart';
import '../../../model/quotation_details_model.dart';
import '../../../router.router.dart';
import 'package:intl/intl.dart';
import '../../../services/add_quotation_services.dart';


class AddQuotationModel extends BaseViewModel {

  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selectedvalidtillDate;
  List<String> searchcustomer = [""];
  List<String> quotationto = ["Customer","Lead","Prospect"];
  List<Items> selectedItems = [];
  List<Items> selectedItemsList = [];
  List<QuotationDetailsModel> quotationdetailsmodel = [];
  Items product = Items();
  // int quantity= 0;
  bool res = false;
  bool isEdit = false;
  bool isSame = false;
  bool isloading = false;
  List<String> ordetype = ["Sales", "Maintenance", "Shopping Cart"];
  TextEditingController customercontroller = TextEditingController();
  TextEditingController customernamecontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController validtilldatecontroller = TextEditingController();

  //TextEditingController quotationtodatecontroller = TextEditingController();
  late String QuotationId;
String name="";
  String customerLabel = 'Customer';
  AddQuotation quotationdata = AddQuotation();

  String displayString='';

  initialise(BuildContext context, String quotationid) async {
    setBusy(true);
    // searchcustomer = await AddQuotationServices().fetchcustomer();
  //  warehouse = await AddQuotationServices().fetchwarehouse();
    QuotationId = quotationid;
    quotationStatus=0;
    //setting aleardy available data
    if (QuotationId != "") {
      quotationdata.items?.clear();
      isEdit = true;
      quotationdata = await AddQuotationServices().getquotation(quotationid) ?? AddQuotation();
      Logger().i(quotationdata.toJson());
      if(quotationdata==quotationdata){
        isSame=true;
        notifyListeners();
      }
      searchcustomer= await AddQuotationServices().getcustomer(quotationdata.quotationTo ?? "");
      quotationStatus=quotationdata.docstatus;
      customercontroller.text = quotationdata.partyName ?? "";
      validtilldatecontroller.text = quotationdata.validTill ?? "";
      customernamecontroller.text=quotationdata.customerName ?? "";
    //  quotationtodatecontroller.text = quotationdata.quotationTo ??"";
      selectedItems.addAll(quotationdata.items?.toList() ?? []);
      updateTextFieldValue();

    }
    quotationdata.orderType = "Sales";
    updateTextFieldValue();
    notifyListeners();
    setBusy(false);
  }


  void onSavePressed(BuildContext context) async {
     if (quotationStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot edit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
    setBusy(true);

    if (formKey.currentState!.validate()) {
      quotationdata.items = selectedItems;

      if (isEdit) {
        handleEdit(context);
      } else {
        handleNonEdit(context);
      }
    }

    setBusy(false);
  }

  void handleEdit(BuildContext context) async {
    name = await AddQuotationServices().addOrder(quotationdata);
    if (name.isNotEmpty) {
      isSame = true;
setBusy(false);
    }
  }

  void handleNonEdit(BuildContext context) async {
    name = await AddQuotationServices().addOrder(quotationdata);
    if (name.isNotEmpty) {

      initialise(context, name);

    }
  }


  void onSubmitPressed(BuildContext context) async {
  if (quotationStatus == 1) {
    Fluttertoast.showToast(
      msg: 'You cannot submit the Submitted document',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
    return; // Move the return statement here
  }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      quotationdata.items = selectedItems;

      quotationdata.docstatus=1;
      bool res=false;
      Logger().i(quotationdata.toJson());

      res = await AddQuotationServices().updateOrder(quotationdata);
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
      quotationdata.items = selectedItems;
      quotationdata.docstatus = 2;
      bool res = false;
      Logger().i(quotationdata.toJson());

      // Assuming AddQuotationServices().cancelOrder(quotationdata) returns a Future<bool>
      res = await AddQuotationServices().cancelOrder(quotationdata);

      if (res) {
        if (context.mounted) {
          setBusy(false);
          // Print statement for debugging
          print("Popping the context...");
          Navigator.pop(context);
        }
      }
    }

    // Make sure to set busy state to false after the operations
    setBusy(false);
  }

  ///dates functions///

  Future<void> selectvalidtillDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedvalidtillDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedvalidtillDate) {
      selectedvalidtillDate = picked;
      isSame=false;
      validtilldatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      quotationdata.validTill = validtilldatecontroller.text;
    }
    notifyListeners();
  }




  ///setvalues//

  void onvalidtillDobChanged(String value) {
    isSame=false;
    quotationdata.validTill = value;
    notifyListeners();
  }

  void setcustomer(String? customer) {
    isSame=false;
    quotationdata.partyName = customer;
    notifyListeners();
  }
  void setquotationto(String? quotationTo) async {
    quotationdata.quotationTo = quotationTo;
    quotationdata.partyName="";
    isSame=false;
    if(quotationTo!.isNotEmpty){
    searchcustomer= await AddQuotationServices().getcustomer(quotationTo);}
    setCustomerLabel(quotationTo);
    notifyListeners();
  }


  void setordertype(String? ordertype) {
    isSame=false;
    quotationdata.orderType = ordertype;
    notifyListeners();
  }

 // Default label for the customer dropdown

  void setCustomerLabel(String? quotationTo) {
    // Customize the label based on the selected value of quotationTo
    if (quotationTo == 'Prospect') {
      customerLabel = 'Prospect';
    } else if (quotationTo == 'Lead') {
      customerLabel = 'Lead';
    } else {
      customerLabel = 'Customer';
    }
    notifyListeners();
  }

  void updateTextFieldValue() {
    final selectedItemsValue = selectedItems.isEmpty
        ?'items are  not selected'
        : '${selectedItems.length} items are selected';
    displayString = selectedItemsValue;
    notifyListeners();
  }



  //
  //
  // void addProduct(String? product) {
  //
  //   bool isItemAlreadyAdded = products.any((existingProduct) =>
  //   existingProduct.productName == product);
  //   Logger().i(product);
  //   final selectedCaneData = productList.firstWhere(
  //           (caneData) => caneData.productName == product);
  //
  //   if (!isItemAlreadyAdded) {
  //     products.add(Product(
  //       productName: selectedCaneData.name,
  //       product: selectedCaneData.product,
  //       description: selectedCaneData.description,
  //     ));
  //     notifyListeners();
  //   }
  // }




  void setSelectedItems(List<Items> SelectedItems) async {
    isSame=false;
    selectedItems = SelectedItems;
    for (var item in selectedItems) {
      item.amount = (item.qty ?? 1.0) * (item.rate ?? 0.0);
    }
    quotationdata.items = selectedItems;
    updateTextFieldValue();
    Logger().i(quotationdata.toJson());
    quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    notifyListeners();
  }

  void quotationdetails(List<QuotationDetailsModel> quotationdetail) {
    isSame=false;
    quotationdata.totalTaxesAndCharges =
    (quotationdetail.isNotEmpty ? quotationdetail[0].totalTaxesAndCharges : 0.0) ;
    quotationdata.grandTotal =
    (quotationdetail.isNotEmpty ? quotationdetail[0].grandTotal : 0.0) ;
    quotationdata.discountAmount =
    (quotationdetail.isNotEmpty ? quotationdetail[0].discountAmount : 0.0) ;
    quotationdata.total = (quotationdetail.isNotEmpty ? quotationdetail[0].netTotal : 0.0) ;
    quotationdata.netTotal = (quotationdetail.isNotEmpty ? quotationdetail[0].netTotal : 0.0) ;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    isSame=false;
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          ((selectedItems[index].qty ?? 0.0) + quantityChange.toDouble());
      selectedItems[index].amount = ((selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0));
      quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    }
    notifyListeners();
  }

  num getQuantity(Items item) {
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

  // void deleteitem(int index) async {
  //   selectedItems.removeAt(index);
  //   notifyListeners();
  //   quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
  //   Logger().i(selectedItems.length);
  // }


  void deleteitem(int index) async {
    isSame=false;
    selectedItems.removeAt(index);
    quotationdata.items=selectedItems;
    quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    Logger().i(selectedItems.length);
    updateTextFieldValue();
    notifyListeners();
    // Trigger the callback when an item is removed

  }


  String? validateordertype(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Order Type';
    }
    return null;
  }

  String? validateQuotationTo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Customer';
    }
    return null;
  }
  String? validateValidTill(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Valid-till';
    }
    return null;
  }

  @override
  void dispose() {
    customercontroller.dispose();
    validtilldatecontroller.dispose();
    customernamecontroller.dispose();
    super.dispose();
  }
}
