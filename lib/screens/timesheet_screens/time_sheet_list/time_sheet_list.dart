import 'package:flutter/material.dart';
import 'package:geolocation/screens/timesheet_screens/time_sheet_list/time_sheet_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/timesheet_model.dart';
import '../../../router.router.dart';


class TimesheetListView extends StatefulWidget {
  @override
  _TimesheetListViewState createState() => _TimesheetListViewState();
}

class _TimesheetListViewState extends State<TimesheetListView> {
  String? selectedMonth;
  int? selectedYear;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<int> years = List.generate(5, (index) => DateTime.now().year + index);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimesheetViewModel>.reactive(
      viewModelBuilder: () => TimesheetViewModel(),
      onDispose: (model) => model.dispose(),
      onModelReady: (model) => model.fetchTimesheets(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Timesheets'),
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
                    // Trigger fetching timesheets based on the selected month/year
                    model.fetchTimesheetsByMonthAndYear(selectedMonth,selectedYear);
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
                    // Trigger fetching timesheets based on the selected month/year
                    model.fetchTimesheetsByMonthAndYear(selectedMonth, selectedYear);
                  });
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Refresh timesheets when the user pulls down
              await model.fetchTimesheets();
            },
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.timesheets.isEmpty
                ? Center(child: Text('No timesheets found.'))
                : ListView.builder(
              itemCount: model.timesheets.length,
              itemBuilder: (context, index) {
                TimesheetDetails? timesheet = model.timesheets[index];

                // Format the start and end dates
                final dateFormat = DateFormat('dd/MM/yyyy');
                String formattedStartDate = dateFormat.format(DateTime.parse(timesheet.startDate!));
                String formattedEndDate = dateFormat.format(DateTime.parse(timesheet.endDate!));

                return Card(
                  child: ListTile(
                    onTap: ()=>{
                        Navigator.pushNamed(
                        context,
                        Routes.timesheetDetailsScreen,
                        arguments: TimesheetDetailsScreenArguments(updateTaskId: timesheet.name ?? ""),
                        )
                    },
                    title: Text(
                      timesheet.title!.isNotEmpty ? timesheet.title! : 'Unnamed',
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
                              'Date: $formattedStartDate',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '- $formattedEndDate',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Hours: ${timesheet.totalHours}',
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
              final result = await Navigator.pushNamed(context, Routes.addTimesheetForm);
              if (result == true) {
                model.fetchTimesheets();
              }
            },
            label: const Text('Add Timesheet'),
          ),
        );
      },
    );
  }
}
