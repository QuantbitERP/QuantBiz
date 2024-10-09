import 'package:flutter/material.dart';
import 'package:geolocation/screens/timesheet_screens/time_sheet_list/time_sheet_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/timesheet_model.dart';
import '../../../router.router.dart';


class TimesheetListView extends StatelessWidget {
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
            backgroundColor: Colors.white, // You can set your preferred color here
          ),
          body: model.isBusy
              ? Center(child: CircularProgressIndicator())
              : model.timesheets.isEmpty
              ? Center(child: Text('No timesheets found.'))
              : ListView.builder(
            itemCount: model.timesheets.length,
            itemBuilder: (context, index) {
              TimesheetDetails? timesheet = model.timesheets[index];

              // Format the start and end dates
              final dateFormat = DateFormat('dd/MM/yyyy');
              String formattedStartDate = dateFormat.format(DateTime.parse(timesheet.startDate));
              String formattedEndDate = dateFormat.format(DateTime.parse(timesheet.endDate));

              return Card(
                child: ListTile(
                  title: Text(
                    timesheet.title.isNotEmpty ? timesheet.title : 'Unnamed',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Title font color
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
                              color: Colors.grey[700], // Subtitle font color for dates
                            ),
                          ),
                          Text(
                            '- $formattedEndDate',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700], // Subtitle font color for dates
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Hours: ${timesheet.totalHours}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800], // Subtitle font color for hours
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    timesheet.status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: timesheet.status == 'Draft' ? Colors.orange : Colors.green, // Dynamic color for status
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(
                context, Routes.addTimesheetForm),
            label: const Text('Add Timesheet'),
          ),
        );
      },
    );
  }
}
