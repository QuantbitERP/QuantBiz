import 'package:flutter/material.dart';
import 'package:geolocation/model/help_desk_model.dart';
import 'package:geolocation/services/help_desk_services.dart';
import 'package:stacked/stacked.dart';


class TicketListViewModel extends BaseViewModel {
  List<Ticket> _ticketList = [];
  List<Ticket> get ticketList=> _ticketList;


  initialise(BuildContext context) async {
    setBusy(true);
    _ticketList = await HelpDeskServices().fetchHelpDeskDetails();
    notifyListeners();
    setBusy(false);
  }


}
