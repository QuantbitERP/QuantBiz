
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_visit_model.dart';
import '../../../services/add_visit_services.dart';


class UpdateVisitModel extends BaseViewModel{

  AddVisitModel visitdata =AddVisitModel();
  initialise(BuildContext context,String visitId) async {
    setBusy(true);
    if(visitId !=""){
      visitdata =await AddVisitServices().getVisit(visitId) ?? AddVisitModel();
      notifyListeners();
    }
    setBusy(false);
  }

}