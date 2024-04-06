import 'package:flutter/cupertino.dart';
import 'package:geolocation/services/profle_services.dart';
import 'package:stacked/stacked.dart';
import '../../model/chane_password.dart';
import '../../router.router.dart';

class ChangePasswordModel extends BaseViewModel{
  TextEditingController currentpasswordcontroller=TextEditingController();
  TextEditingController newpasswordcontroller=TextEditingController();
  ChangePassword change=ChangePassword();
  bool res=false;
  bool currentpasssword=false;
  bool newpassword=false;
  initialise(BuildContext context){

  }
  final formKey = GlobalKey<FormState>();
  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
        res = await ProfileServices().changepassword(change);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pop(context);
          }}
    }
    setBusy(false);
  }
  void setcurrentpassword(String firstname){
    currentpasswordcontroller.text=firstname;
    change.currentpassword =currentpasswordcontroller.text;
    notifyListeners();
  }

  void setnewpassword(String firstname){
    newpasswordcontroller.text=firstname;
    change.newpassword =newpasswordcontroller.text;
    notifyListeners();
  }

  String? validatcurrentpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'required!';
    }
    return null;
  }
  String? validatnewpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'required!';
    }
    return null;
  }


  @override
  void dispose() {
    currentpasswordcontroller.dispose();
    newpasswordcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}