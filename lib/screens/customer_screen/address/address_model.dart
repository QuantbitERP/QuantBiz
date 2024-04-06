import 'package:flutter/material.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:stacked/stacked.dart';

class AddressModel extends BaseViewModel{

  Shipping shipping= Shipping(); Billing billing= Billing();
  TextEditingController billingAddressLine1Controller = TextEditingController();
  TextEditingController billingAddressLine2Controller = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingStateController = TextEditingController();
  TextEditingController billingPostalCodeController = TextEditingController();
  TextEditingController shippingAddressLine1Controller = TextEditingController();
  TextEditingController shippingAddressLine2Controller = TextEditingController();
  TextEditingController shippingCityController = TextEditingController();
  TextEditingController shippingStateController = TextEditingController();
  TextEditingController shippingPostalCodeController = TextEditingController();
  List<String> state = [
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Ladakh",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Other Countries",
    "Other Territory"
  ];

  initialise(BuildContext context,Billing editBilling,Shipping editShipping)async{
    setBusy(true);
  billing.state="Maharashtra";
    shipping.state="Maharashtra";
    if(editBilling.country!=null ||editShipping.country!=null){
      billing=editBilling;
      shipping=editShipping;
      billingAddressLine1Controller.text = editBilling.addressLine1 ?? "";
      billingAddressLine2Controller.text = editBilling.addressLine2 ?? "";
      billingCityController.text = editBilling.city ?? "";
      billingPostalCodeController.text = editBilling.pincode ?? "";
      shippingAddressLine1Controller.text = editShipping.addressLine1 ?? "";
      shippingAddressLine2Controller.text = editShipping.addressLine2 ?? "";
      shippingCityController.text = editShipping.city ?? "";
      shippingPostalCodeController.text = editShipping.pincode ?? "";

    }
    setBusy(false);
    notifyListeners();
  }

  
  void onSavedPressed(BuildContext context){
billing.addressLine1=billingAddressLine1Controller.text;
billing.addressLine2=billingAddressLine2Controller.text;
billing.city=billingCityController.text;
billing.pincode=billingPostalCodeController.text;
billing.country= "India";

shipping.addressLine1=shippingAddressLine1Controller.text;
shipping.addressLine2=shippingAddressLine2Controller.text;
shipping.city=shippingCityController.text;
shipping.pincode=shippingPostalCodeController.text;
shipping.country= "India";
    // You can handle this data as needed, e.g., pass it back to the AddCustomer screen
    Navigator.pop(context, [billing,shipping]);
  }

  void setEmail(String? state){
    billing.state =state;
    notifyListeners();
  }
  void setShippingState(String? state){
    shipping.state =state;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  billingAddressLine1Controller.dispose();
   billingAddressLine2Controller.dispose();
  billingCityController.dispose();
billingStateController.dispose();
billingPostalCodeController.dispose();
shippingAddressLine1Controller.dispose();
shippingAddressLine2Controller.dispose();
shippingCityController.dispose();
shippingStateController.dispose();
shippingPostalCodeController.dispose();
    super.dispose();
  }
}