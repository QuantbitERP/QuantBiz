import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/timesheet_screens/time_log/time_log_view_model.dart';
import 'package:stacked/stacked.dart';

class TimeLogDialog extends StatelessWidget {
  final String project; // Define project as a final variable

  // Constructor to accept the project string
  TimeLogDialog( this.project); // Using a named parameter

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<TimeLogViewModel>.reactive(
      viewModelBuilder: () => TimeLogViewModel(),
      onDispose: (model) => model.dispose(),
      // Pass the project to the ViewModel in onViewModelReady
      onViewModelReady: (model) => model.initialize(context, project),
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
                  DropdownButtonFormField<String>(
                    value: viewModel.selectedTask,
                    items: viewModel.tasks.toSet().map((String task) {
                      return DropdownMenuItem<String>(
                        value: task,
                        child: Text(task), // Display task name in dropdown
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                     viewModel.setTask(newValue!);
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Task',
                      border: OutlineInputBorder(),
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
                    controller: TextEditingController(
                      text: "${viewModel.fromTime.toLocal().toString().split(' ')[0]} ${viewModel.fromTime.toLocal().toString().split(' ')[1].substring(0, 5)}",
                    ),
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
                    controller: TextEditingController(
                      text: "${viewModel.toTime.toLocal().toString().split(' ')[0]} ${viewModel.toTime.toLocal().toString().split(' ')[1].substring(0, 5)}",
                    ),
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
                    controller: TextEditingController(text: viewModel.hours.toString()),
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
                    controller: TextEditingController(text: viewModel.project), // Show project passed to dialog
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
                    controller: TextEditingController(text: viewModel.description),
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
