import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_timesheet_model.dart';
import '../../../widgets/drop_down.dart';
import '../time_log/time_log_dialog.dart';
import 'add_timesheet_form_view_model.dart';

class AddTimesheetForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Timesheet'),
      ),
      body: ViewModelBuilder<AddTimeSheetViewModel>.reactive(
        viewModelBuilder: () => AddTimeSheetViewModel(),
        onDispose: (model) => model.dispose(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: SingleChildScrollView( // Added SingleChildScrollView to allow scrolling
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: TextEditingController(text: viewModel.employee),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onChanged: (value) {
                        viewModel.updateName(value);
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: TextEditingController(text: viewModel.company),
                      decoration: InputDecoration(
                        labelText: 'Company',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onChanged: (value) {
                        viewModel.updateCompany(value);
                      },
                    ),
                    SizedBox(height: 16.0),
                    CustomDropdownButton2(
                        value: viewModel.project,
                        prefixIcon: Icons.local_post_office_outlined,
                        items: viewModel.projectList,
                        hintText: 'Select the project',
                        labelText: 'Project',
                        onChanged: (value){
                          viewModel.updateProject(value!);
                         // viewModel.selectedProject = value!;
                        }
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onChanged: (value) {
                        viewModel.updateRemarks(value);
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildDateField(context, viewModel, 'Start Date', viewModel.startDate, viewModel.updateStartDate),
                    SizedBox(height: 16.0),
                    _buildDateField(context, viewModel, 'End Date', viewModel.endDate, viewModel.updateEndDate),
                    SizedBox(height: 16.0),
                    Text('Time Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    _buildTimeLogList(viewModel),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        final timeLog = await showDialog<TimeLog>(
                          context: context,
                          builder: (context) {
                            return TimeLogDialog(viewModel.selectedProject);
                          },
                        );
                        if (timeLog != null) {
                          viewModel.addTimeLog(timeLog);
                        }
                      },
                      child: Text('Add Time Log'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.submitForm(context);
                      },
                      child: Text('Submit Timesheet'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateField(BuildContext context, AddTimeSheetViewModel viewModel, String label, DateTime date, Function(DateTime) onUpdate) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          onUpdate(pickedDate);
        }
      },
      controller: TextEditingController(
        text: date.toLocal().toString().split(' ')[0],
      ),
    );
  }

  Widget _buildTimeLogList(AddTimeSheetViewModel viewModel) {
    return SizedBox(
      height: 150.0, // Set a fixed height to avoid layout issues
      child: ListView.builder(
        itemCount: viewModel.timeLogs.length,
        itemBuilder: (context, index) {
          final timeLog = viewModel.timeLogs[index];
          return Card(
            child: ListTile(
              title: Text('${timeLog.activityType} (${timeLog.hours} hrs)'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${timeLog.project}'),
                  Text(timeLog.task),

                ],  ),
              ),
          );
        },
      ),
    );
  }
}
