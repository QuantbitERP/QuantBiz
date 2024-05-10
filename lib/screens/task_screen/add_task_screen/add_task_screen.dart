import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_task_viewModel.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTaskViewModel>.reactive(
        viewModelBuilder: () => AddTaskViewModel(),
    onViewModelReady: (model) => model.initialise(context),
    builder: (context, model, child)=> Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
child: Column(
  children: [

  ],
),
      ),
    ));
  }
}
