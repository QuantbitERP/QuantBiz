import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocation/screens/timesheet_screens/time_log/time_log_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_timesheet_model.dart';
import '../../../model/list_task_model.dart';
import '../../../widgets/custom_task_dropdown.dart';


class TimeLogDialog extends StatelessWidget {
  final TimeLog? existingTimeLog; // Optional existing TimeLog
  final String project;
// Constructor to accept project and existing TimeLog
  TimeLogDialog(this.project, this.existingTimeLog);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<TimeLogViewModel>.reactive(
      viewModelBuilder: () => TimeLogViewModel(),
      onDispose: (model) => model.dispose(),
      // Pass the project to the ViewModel in onViewModelReady
      onViewModelReady: (model) => model.initialize(context, project,existingTimeLog),
      builder: (context, viewModel, child) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: screenWidth,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Time Log',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  // Dropdown for Activity Type
                  DropdownButtonFormField<String>(
                    value: viewModel.activityType.isNotEmpty ? viewModel.activityType : null,
                    decoration: InputDecoration(
                      labelText: 'Activity Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    items: viewModel.activityTypes.map((String activity) {
                      return DropdownMenuItem<String>(
                        value: activity,
                        child: Text(activity),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        viewModel.setActivityType(value);
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  // Dropdown for Task
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Rounded corners for card
                    ),
                    elevation: 4.0, // Add shadow for depth effect
                    child: Padding(
                      padding:
                      const EdgeInsets.all(8.0),
                  // Padding inside card
                      child: CustomSearchableDropdown(
                        selectedTask: viewModel.selectedTask,
                        taskList: viewModel.taskList,
                        onChanged: (TaskList? selectedTask) {
                          viewModel.setTask(selectedTask!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // TextField for Hours

                  // TextField for From Time
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'From Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: viewModel.fromTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(viewModel.fromTime),
                        );
                        if (pickedTime != null) {
                          viewModel.setFromTime(DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          ));
                        }
                      }
                    },
                    controller: viewModel.fromTimeController,

                  ),
                  SizedBox(height: 16.0),
                  // TextField for To Time
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'To Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: viewModel.toTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(viewModel.toTime),
                        );
                        if (pickedTime != null) {
                          viewModel.setToTime(DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          ));
                        }
                      }
                    },
                    controller:viewModel.toTimeController

                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Hours',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: viewModel.hoursController,
                    onChanged: viewModel.setHours,
                  ),

                  SizedBox(height: 16.0),
                  // TextField for Project
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Project',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    controller: viewModel.projectController ,// Show project passed to dialog
                    readOnly: true,
                  ),
                  SizedBox(height: 16.0),
                  // TextField for Description
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    controller: viewModel.descriptionController,
                    onChanged: viewModel.setDescription,
                    maxLines: 2,
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      final timeLog = viewModel.timeLog;
                      Navigator.of(context).pop(timeLog);
                    },
                    child: Text('Add Time Log'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
