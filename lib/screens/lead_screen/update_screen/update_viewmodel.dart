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

class UpdateLeadModel extends BaseViewModel{
  final CallsAndMessagesService service = CallsAndMessagesService();
String? note;
TextEditingController controller=TextEditingController();
List<String> status=["Not Interested",
  "Call Back",
  "Converted For Demo",
  "Details Shared",
  "Ringing",
  "Busy",
  "Switch Off"];

  AddLeadModel leaddata =AddLeadModel();
bool res=false;
List<NotesList> notes=[];
  initialise(BuildContext context,String leadId) async {
    setBusy(true);
    if(leadId !=""){
 leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();
 notes=await UpdateLeadServices().getnotes(leadId);
 Logger().i(leaddata.toJson());
 Logger().i(notes.length);
 notifyListeners();
    }
    setBusy(false);
  }

  whatsapp(String contact) async {
    //var contact = "+917888187242";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, ${leaddata.company} here";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Text('WhatsApp is not installed.');
    }
  }

void deletenote(String? lead,int? index)async{
  Logger().i(lead);
  Logger().i(index);
  if(lead!.isNotEmpty && index!.bitLength != 0){
    // notes.removeAt(index);
 res=await UpdateLeadServices().deletenotes(lead, index);
 if(res){
  notes=await UpdateLeadServices().getnotes(lead);
  
 }
}
 notifyListeners();
}

void addnote(String? lead,dynamic note)async{
    Logger().i(lead);
  Logger().i(note);
  if(lead!.isNotEmpty && note!.isNotEmpty){
 res=await UpdateLeadServices().addnotes(lead, note);}
  if(res){
  notes=await UpdateLeadServices().getnotes(lead);
 }
controller.clear();
notifyListeners();
}


void changestatus(String? lead,String? type)async{
  if(lead!.isNotEmpty && type!.isNotEmpty){
  await UpdateLeadServices().changestatus(lead,type);
  leaddata.customCallStatus=type;}
  notifyListeners();
}
}