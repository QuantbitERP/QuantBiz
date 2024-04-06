import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../model/quotation_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_quotation_services.dart';


class ListQuotationModel extends BaseViewModel {
  List<QuotationList> quotationlist = [];
  List<QuotationList> filterquotationlist = [];
  List<String> customer=[""];
  List<String> quotation=["Customer","Lead"];
  initialise(BuildContext context) async {
    setBusy(true);
     quotationlist = await QuotationServices().fetchquotation();
     filterquotationlist=quotationlist;
     customer=await QuotationServices().getcustomer();
    setBusy(false);
  }

  void onRowClick(BuildContext context, QuotationList? QList) {
    Navigator.pushNamed(
      context,
      Routes.addQuotationView,
     arguments: AddQuotationViewArguments(quotationid: QList?.name ?? ""),

    );
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Draft':
        return Colors.grey[400] ??
            Colors.grey; // Set the color for Draft status
      case 'Open':
        return Colors.orangeAccent; // Set the color for On Hold status
      case 'Partially Ordered':
        return Colors.yellow; // Set the color for To Deliver and Bill status
      case 'Ordered':
        return Colors.green; // Set the color for To Bill status
      case 'Lost':
        return Colors.grey; // Set the color for To Deliver status
      case 'Expired':
        return Colors.red; // Set the color for Completed status
      case 'Cancelled':
        return Colors.red; // Set the color for Cancelled status
      // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }


  Future<void> refresh() async {
    filterquotationlist=await QuotationServices().fetchquotation();
    notifyListeners();
  }

  String? custm;
  String? quotationto;

  void setcustomer(String? customer) {
    custm = customer ?? "";
    notifyListeners();
  }

  void setquotationto(String? quotation) {
    quotationto = quotation ?? "";
    notifyListeners();
  }

  void setfilter(String quotaion,String customer) async {
    filterquotationlist= await QuotationServices().fetchfilterquotation(quotaion, customer);
    notifyListeners();
  }

  void clearfilter() async {
    quotationto="";
    custm="";
    filterquotationlist= await QuotationServices().fetchquotation();
    notifyListeners();
  }

}
