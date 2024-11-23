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

  // Function to show the bottom sheet
  void _showTaskSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search bar with padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: filterTasks,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              // Task List with a good UI
              Container(
                height: 300.0, // Set a fixed height for the list
                child: ListView(
                  children: filteredTasks.map((TaskList task) {
                    return InkWell(
                      onTap: () {
                        widget.onChanged(task); // Update selected task
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.task, color: Colors.blueAccent),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.subject!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTaskSearchBottomSheet(context); // Open bottom sheet when tapped
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
       height: 45,

        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                widget.selectedTask?.subject ?? 'Select Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: widget.selectedTask != null
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
