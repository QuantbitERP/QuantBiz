import 'package:flutter/material.dart';
import 'package:geolocation/model/help_desk_model.dart';
import 'package:geolocation/screens/helpdesk/ticket_list_view_model.dart';
import 'package:geolocation/screens/timesheet_screens/time_sheet_list/time_sheet_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/timesheet_model.dart';
import '../../../router.router.dart';


class TicketListScreen extends StatefulWidget {
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  String? selectedMonth;
  int? selectedYear;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<int> years = List.generate(5, (index) => DateTime.now().year + index);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TicketListViewModel>.reactive(
      viewModelBuilder: () => TicketListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      onDispose: (model) => model.dispose(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tickets'),
            backgroundColor: Colors.white,
            actions: [
              // Dropdown for month selection
              DropdownButton<String>(
                value: selectedMonth,
                hint: Text('Month'),
                items: months.map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue;

                  });
                },
              ),
              SizedBox(width: 10),
              // Dropdown for year selection
              DropdownButton<int>(
                value: selectedYear,
                hint: Text('Year'),
                items: years.map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(year.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue;

                  });
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {

            },
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.ticketList.isEmpty
                ? Center(child: Text('No timesheets found.'))
                : ListView.builder(
              itemCount: model.ticketList.length,
              itemBuilder: (context, index) {
                Ticket? timesheet = model.ticketList[index];

                // // Format the start and end dates
                // final dateFormat = DateFormat('dd/MM/yyyy');
                // String formattedStartDate = dateFormat.format(DateTime.parse(timesheet.startDate!));
                // String formattedEndDate = dateFormat.format(DateTime.parse(timesheet.endDate!));

                return Card(
                  child: ListTile(
                    onTap: ()=>{
                      // Navigator.pushNamed(
                      //   context,
                      //   Routes.timesheetDetailsScreen,
                      //   arguments: TimesheetDetailsScreenArguments(updateTaskId: timesheet.name ?? ""),
                      // )
                    },
                    title: Text(
                      timesheet.subject!.isNotEmpty ? timesheet.subject! : '--',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

                            Text(
                              'Priority: ${timesheet.priority}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                          Text(
                            'Status: ${timesheet.status}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    trailing: Text(
                      timesheet.status!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: timesheet.status == 'Draft' ? Colors.orange : Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {

              var result = Navigator.pushNamed(context, Routes.addTimesheetForm, arguments: AddTimesheetFormArguments(
                  timeSheetId: ""));

              if (result == true) {
               // model.fetchTimesheets();
              }
            },
            label: const Text('Add Ticket'),
          ),
        );
      },
    );
  }
}
