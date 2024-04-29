import 'package:flutter/material.dart';
import 'package:geolocation/model/visit_list_model.dart';
import 'package:geolocation/services/list_visit_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';

class VisitViewModel extends BaseViewModel{

List<VisitListModel> visitList=[];


  initialise(BuildContext context) async {
    setBusy(true);

visitList=await ListVisitServices().fetchVisit();
    notifyListeners();
    setBusy(false);
  }

void onRowClick(BuildContext context, VisitListModel? farmresList) {
  Navigator.pushNamed(
    context,
    Routes.addVisitScreen,
    arguments: AddVisitScreenArguments(VisitId: farmresList?.name ?? ""),
  );
}
}