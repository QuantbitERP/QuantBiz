import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocation/model/add_lead_model.dart';
import 'package:geolocation/model/notes_list.dart';
import 'package:geolocation/services/update_lead_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/add_lead_services.dart';
import '../../../services/call_services.dart';

class UpdateVisitModel extends BaseViewModel{


  AddLeadModel leaddata =AddLeadModel();

  initialise(BuildContext context,String leadId) async {
    setBusy(true);
    if(leadId !=""){
      leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();

      notifyListeners();
    }
    setBusy(false);
  }

}