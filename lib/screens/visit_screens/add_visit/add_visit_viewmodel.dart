import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocation/model/add_visit_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../services/add_leave_services.dart';
import '../../../services/add_visit_services.dart';
import '../../../services/geolocation_services.dart';

class AddVisitViewModel extends BaseViewModel{
  TextEditingController descriptoncontroller=TextEditingController();

  AddVisitModel visitdata =AddVisitModel();
  final formKey = GlobalKey<FormState>();
  List<String> visitType=[""];
  List<String> customer=[""];
  bool isEdit = false;

  initialise(BuildContext context, String visitId) async {
    setBusy(true);
    visitType=await AddVisitServices().fetchVisitType();
    customer=await AddVisitServices().fetchcustomer();
    if(visitId!=""){
      isEdit = true;
      visitdata =await AddVisitServices().getVisit(visitId) ?? AddVisitModel();
      descriptoncontroller.text=visitdata.description ?? "";
    }
    setBusy(false);
  }

  
  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      Logger().i(visitdata.toJson());
      bool res = false;
      GeolocationService geolocationService = GeolocationService();
      try {
        Position? position = await geolocationService.determinePosition();

        if (position == null) {
          Fluttertoast.showToast(msg: 'Failed to get location');
          return setBusy(false);
        }

        Placemark? placemark = await geolocationService.getPlacemarks(position);
        if (placemark == null) {
          Fluttertoast.showToast(msg: 'Failed to get placemark');
          return setBusy(false);
        }

        String formattedAddress =
            await geolocationService.getAddressFromCoordinates(
                position.latitude, position.longitude) ??
                "";
        visitdata.latitude = position.latitude.toString();
        visitdata.longitude = position.longitude.toString();
        visitdata.location = formattedAddress;

        res = await AddVisitServices().addVisit(visitdata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pop(context);
          }}
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } finally {
        setBusy(false);
      }

    }
    setBusy(false);
  }


  void setcustomer(String? expenseDate){
    visitdata.customer =expenseDate;
    notifyListeners();
  }

  void setdescription(String expenseDescription){
    descriptoncontroller.text=expenseDescription;
    visitdata.description =descriptoncontroller.text;
    notifyListeners();
  }


  void seteleavetype(String? expenseType){
    visitdata.visitType =expenseType;
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
    super.dispose();
  }
}