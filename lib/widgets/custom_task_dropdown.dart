import 'package:flutter/material.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:stacked/stacked.dart';

import '../model/list_task_model.dart';

class CustomSearchableDropdown extends StatefulWidget {
  final TaskList? selectedTask;
  final List<TaskList> taskList;
  final ValueChanged<TaskList?> onChanged;

  const CustomSearchableDropdown({
    Key? key,
    required this.selectedTask,
    required this.taskList,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSearchableDropdownState createState() => _CustomSearchableDropdownState();
}

class _CustomSearchableDropdownState extends State<CustomSearchableDropdown> {
  String searchText = '';
  late List<TaskList> filteredTasks;

  @override
  void initState() {
    super.initState();
    filteredTasks = widget.taskList;
  }

  void filterTasks(String query) {
    setState(() {
      searchText = query;
      // Filter the list only when there's a search text, otherwise reset it.
      if (query.isEmpty) {
        filteredTasks = widget.taskList;
      } else {
        filteredTasks = widget.taskList
            .where((task) =>
        task.subject!.toLowerCase().contains(query.toLowerCase()) ||
            task.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: filterTasks,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 8.0),

        DropdownButtonHideUnderline(
          child: DropdownButton<TaskList>(
            value: widget.selectedTask,
            hint: Text('Select the task'),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            dropdownColor: Colors.white,
            items: filteredTasks.map((TaskList task) {
              return DropdownMenuItem<TaskList>(
                value: task,
                child: Row(
                  children: [
                    const Icon(Icons.task, color: Colors.blueAccent),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.subject!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          task.name!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (TaskList? selectedTask) {
              widget.onChanged(selectedTask);
            },
          ),
        ),
      ],
    );
  }
}
