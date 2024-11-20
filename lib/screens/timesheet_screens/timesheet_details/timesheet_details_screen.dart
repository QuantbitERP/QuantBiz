import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocation/screens/task_screen/update_task_screen/update_task_viewmodel.dart';
import 'package:geolocation/screens/timesheet_screens/timesheet_details/timesheet_details_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../router.router.dart';

class TimesheetDetailsScreen extends StatefulWidget {
  final String updateTaskId;
  const TimesheetDetailsScreen({super.key, required this.updateTaskId});

  @override
  State<TimesheetDetailsScreen> createState() => _TimesheetDetailsScreenState();
}

class _TimesheetDetailsScreenState extends State<TimesheetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimesheetDetailsViewModel>.reactive(
        viewModelBuilder: () => TimesheetDetailsViewModel(),
        onViewModelReady: (model) =>
            model.initialise(context, widget.updateTaskId),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(widget.updateTaskId),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.addTaskScreen,
                          arguments: AddTaskScreenArguments(
                              taskId: widget.updateTaskId)),
                      icon: const Icon(Icons.edit))
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: fullScreenLoader(
                    loader: model.isBusy,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${model.taskData.company}' ?? "--",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        AutoSizeText(
                          model.taskData.parentProject ?? "",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                        // AutoSizeText(
                        //  // model.taskData.totalHours ?? "",
                        //   style: const TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.black54),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: model.getColorForPriority(
                                      model.taskData.parentProject.toString()),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 7),
                                child: AutoSizeText(
                                 '${model.taskData.employeeName}' ?? "--",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: model.getColorForStatus(
                                      model.taskData.status.toString()),
                                ),
                              ),
                              // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                              child:AutoSizeText(

                                model.taskData.status ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(

                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildItemColumn(
                                    additionalText:
                                        (model.taskData.parentProject ?? 0.0)
                                            .toString(),
                                    labelText: 'Project'),
                                buildItemColumn(
                                    additionalText:
                                        (model.taskData.totalHours ?? 0.0)
                                            .toString(),
                                    labelText: 'Total Hours'),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildItemColumn(
                                    additionalText:
                                    (model.taskData.startDate ?? 0.0)
                                        .toString(),
                                    labelText: 'Start Time'),
                                buildItemColumn(
                                    additionalText:
                                    (model.taskData.endDate ?? 0.0)
                                        .toString(),
                                    labelText: 'End Time'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          "Task Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: model.taskData.timeLogs?.length ?? 0, // Handle null safety
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8), // Margin around the card
                              elevation: 4, // Shadow effect for the card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Project Name
                                    Row(
                                      children: [
                                        Icon(Icons.work, size: 16, color: Colors.orange), // Icon for project
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Project Name: ${model.taskData.timeLogs?[index].projectName ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // Task Name
                                    Row(
                                      children: [
                                        Icon(Icons.task, size: 16, color: Colors.green), // Icon for task
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Task Name: ${model.taskData.timeLogs?[index].task ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // Activity Type
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 16, color: Colors.blue), // Icon for activity
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Activity Type: ${model.taskData.timeLogs?[index].activityType ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // From Time
                                    Row(
                                      children: [
                                        Icon(Icons.timer, size: 16, color: Colors.red), // Icon for from time
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'From Time: ${model.taskData.timeLogs?[index].fromTime ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // To Time
                                    Row(
                                      children: [
                                        Icon(Icons.timer_off, size: 16, color: Colors.red), // Icon for to time
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'To Time: ${model.taskData.timeLogs?[index].toTime ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // Description
                                    Row(
                                      children: [
                                        Icon(Icons.description, size: 16, color: Colors.purple), // Icon for description
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Description: ${model.taskData.timeLogs?[index].description ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 2, // Allow description to span multiple lines
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // Hours
                                    Row(
                                      children: [
                                        Icon(Icons.hourglass_full, size: 16, color: Colors.blueAccent), // Icon for hours
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Hours: ${model.taskData.timeLogs?[index].hours ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                    context: context),
              ),
            ));
  }

  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          minFontSize: 14,
        ),
        AutoSizeText(additionalText,
            style: const TextStyle(fontWeight: FontWeight.w500),
            minFontSize: 16),
      ],
    );
  }
}
