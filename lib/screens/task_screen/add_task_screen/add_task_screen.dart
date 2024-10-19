import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_task_model.dart';
import '../../../model/list_task_model.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';
import 'add_task_viewModel.dart';

class AddTaskScreen extends StatefulWidget {
  final String taskId;
  const AddTaskScreen({super.key, required this.taskId});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTaskViewModel>.reactive(
        viewModelBuilder: () => AddTaskViewModel(),
        onViewModelReady: (model) => model.initialise(context, widget.taskId),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(model.idEdit ? widget.taskId : 'Create Task'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: fullScreenLoader(
                  context: context,
                  loader: model.isBusy,
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
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
                                value: model.selectedProject,
                                hint: Text('Select the project'),
                                isExpanded: true, // To ensure full-width dropdown
                                icon: Icon(Icons
                                    .arrow_drop_down), // Customize dropdown arrow
                                dropdownColor: Colors
                                    .white, // Change the dropdown popup background
                                items: model.projectList.map((Project project) {
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
                                    model.changeProject(selectedProject);
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                        ,
                        const SizedBox(
                          height: 15,
                        ),
                        CustomSmallTextFormField(
                          controller: model.subject,
                          labelText: 'Subject',
                          hintText: "Enter the subject",
                          prefixIcon: Icons.subject,
                          onChanged: model.changeSubject,
                          validator: model.validate,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomSmallTextFormField(
                          linelength: 3,
                          controller: model.description,
                          labelText: 'Description',
                          hintText: "Enter the Description",
                          onChanged: model.changeDescription,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomMultiDropdownButton2(
                            items: model.userList,
                            hintText: '',
                            onChanged: model.onChanged,
                            value: model.assignToList,
                            labelText: 'Assign To'),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: model.taskData.priority,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.priority_high_outlined),
                            labelText: 'Priority',
                            hintText: 'Enter the priority',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2)),
                          ),
                          items: model.priorityItem.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: AutoSizeText(val),
                            );
                          }).toList(),
                          onChanged: (value) => model.changePriority(value),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: model.endDate,
                          onTap: () => model.selectdeliveryDate(context),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month),
                            labelText: 'Due Date',
                            hintText: 'Enter the Due Date',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: model.taskData.status,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.flag),
                            labelText: 'Status',
                            hintText: 'Enter the Status',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2)),
                          ),
                          items: model.statusItem.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: AutoSizeText(val),
                            );
                          }).toList(),
                          onChanged: (value) => model.changeStatus(value),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                              child: DropdownButton<TaskList>(
                                value: model.selectedTask,
                                hint: Text('Select the task'),
                                isExpanded: true, // To ensure full-width dropdown
                                icon: Icon(Icons
                                    .arrow_drop_down), // Customize dropdown arrow
                                dropdownColor: Colors
                                    .white, // Change the dropdown popup background
                                items: model.taskList.map((TaskList taskList) {
                                  return DropdownMenuItem<TaskList>(
                                    value: taskList,
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
                                              taskList.subject!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0, // Custom text size
                                              ),
                                            ),
                                            Text(
                                              taskList.name!,
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
                                onChanged: (TaskList? selectedTask) {
                                  if (selectedTask != null) {
                                    model.setTask(selectedTask);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: CtextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                text: 'Cancel',
                                buttonColor: Colors.redAccent.shade400,
                              )),
                              SizedBox(width: 20),
                              Expanded(
                                  child: CtextButton(
                                onPressed: () => model.onSavePressed(context),
                                text: model.idEdit
                                    ? 'Update Task'
                                    : 'Create Task',
                                buttonColor: Colors.blueAccent.shade400,
                              ))
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
