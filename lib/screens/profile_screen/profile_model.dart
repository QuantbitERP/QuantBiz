import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/employee_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../services/profle_services.dart';

class ProfileViewModel extends BaseViewModel {
  bool res = false;
  EmployeeDetails employeedetail = EmployeeDetails();
  initialise(BuildContext context) async {
    setBusy(true);
    employeedetail = await ProfileServices().profile() ?? EmployeeDetails();
    setBusy(false);
    notifyListeners();
  }

  Future<void> selectPdf(ImageSource source) async {
    try {
      final result = await ImagePicker().pickImage(source: source);

      if (result == null) {
        return;
      }

      setBusy(true);

      File? compressedFile = await compressFile(fileFromXFile(result));
      Logger().i(result);

      String aadharUrl = await ProfileServices().uploadDocs(compressedFile);
      Logger().i(aadharUrl);

      res = await ProfileServices().updateProfilePicture(aadharUrl);
      employeedetail = await ProfileServices().profile() ?? EmployeeDetails();

      setBusy(false);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error while picking an image or document: $e',
      );
    }
  }
}
