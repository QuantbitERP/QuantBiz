import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_task_model.dart';
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
              child: SingleChildScrollView(
                physics:
                    AlwaysScrollableScrollPhysics(), // Added SingleChildScrollView to allow scrolling
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller:
                          TextEditingController(text: viewModel.employee),
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
                      controller:
                          TextEditingController(text: viewModel.company),
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
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Rounded corners for card
                      ),
                      elevation: 4.0, // Add shadow for depth effect
                      child: Padding(
                        padding:
                            const EdgeInsets.all(8.0), // Padding inside card
                        child: DropdownButtonHideUnderline(
                          // Hide the default underline of DropdownButton
                          child: DropdownButton<Project>(
                            value: viewModel.selectedProject,
                            hint: Text('Select the project'),
                            isExpanded: true, // To ensure full-width dropdown
                            icon: Icon(Icons
                                .arrow_drop_down), // Customize dropdown arrow
                            dropdownColor: Colors
                                .white, // Change the dropdown popup background
                            items: viewModel.projectList.map((Project project) {
                              return DropdownMenuItem<Project>(
                                value: project,
                                child: Row(
                                  children: [
                                    const Icon(Icons.task,
                                        color: Colors
                                            .blueAccent), // Custom icon color
                                    SizedBox(
                                        width:
                                            10.0), // Space between icon and text
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          project.projectName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0, // Custom text size
                                          ),
                                        ),
                                        Text(
                                          project.name,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Project? selectedProject) {
                              if (selectedProject != null) {
                                viewModel.updateProject(selectedProject);
                              }
                            },
                          ),
                        ),
                      ),
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
                    _buildDateField(context, viewModel, 'Start Date',
                        viewModel.startDate, viewModel.updateStartDate),
                    SizedBox(height: 16.0),
                    _buildDateField(context, viewModel, 'End Date',
                        viewModel.endDate, viewModel.updateEndDate),
                    SizedBox(height: 16.0),
                    Text('Time Logs',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    _buildTimeLogList(viewModel, context),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        final timeLog = await showDialog<TimeLog>(
                          context: context,
                          builder: (context) {
                            return TimeLogDialog(
                                viewModel.selectedProject != null ? viewModel.selectedProject!.name : "--",
                                null
                            );
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

  Widget _buildDateField(BuildContext context, AddTimeSheetViewModel viewModel,
      String label, DateTime date, Function(DateTime) onUpdate) {
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

  Widget _buildTimeLogList(
      AddTimeSheetViewModel viewModel, BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.timeLogs.length,
      shrinkWrap: true,
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
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Show a confirmation dialog before removing
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirm Delete"),
                      content: Text("Are you sure you want to delete this time log?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Remove the time log
                            viewModel.removeTimeLog(index);
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            onTap: () async {
              final timeLogDetails = await showDialog<TimeLog>(
                context: context,
                builder: (context) {
                  return TimeLogDialog(viewModel.selectedProject!.name ?? "--", timeLog);
                },
              );

              if (timeLogDetails != null) {
                viewModel.updateTimeLog(index, timeLogDetails);
              }
            },
          ),
        );
      },
    );
  }

}
