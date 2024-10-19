
import 'package:flutter/cupertino.dart';
import 'package:geolocation/services/timesheet_services.dart';
import '../../../model/add_timesheet_model.dart';
import '../../../model/list_task_model.dart';
import '../../../services/list_task_service.dart';

class TimeLogViewModel extends ChangeNotifier {
  String _activityType = '';
  String _task = '';
  double _hours = 0.0;
  DateTime _fromTime = DateTime.now();
  DateTime _toTime = DateTime.now();
  String _project = '';
  String _description = '';
  List<String> activityTypes = []; // Example values
  List<String> tasks = []; // Example values
  TaskList? selectedTask;
  List<TaskList> taskList = [];
  bool _isDisposed = false; // Flag to check if disposed

  var projectController = TextEditingController();
  var descriptionController = TextEditingController();
  var fromTimeController = TextEditingController();
  var toTimeController = TextEditingController();
  var hoursController = TextEditingController();

  String get activityType => _activityType;
  String get task => _task;
  double get hours => _hours;
  DateTime get fromTime => _fromTime;
  DateTime get toTime => _toTime;
  String get project => _project;
  String get description => _description;

  // Initialize method for fetching data
  Future<void> initialize(BuildContext context, String s, TimeLog? existingTimeLog) async {
    activityTypes = await TimesheetServices().fetchActivityTypes();

    if (_isDisposed) return; // Prevent further execution if disposed

    taskList = await TaskListService().fetchTask();

    tasks = getTaskNames(taskList);

    if (existingTimeLog != null) {
      // If editing, populate fields with existing data
      _activityType = existingTimeLog.activityType;
      _task = existingTimeLog.task;
      _fromTime = existingTimeLog.fromTime;
      _toTime = existingTimeLog.toTime;
      _hours = existingTimeLog.hours;
      _description = existingTimeLog.description;
      selectedTask = taskList.firstWhere((task) => task.name == existingTimeLog.task, orElse: () => taskList.first);

    }

    setProject(s);
  }

  List<String> getTaskNames(List<TaskList> taskList) {
    return taskList.map((task) => task.subject!).toList();
  }

  // String? getTaskIdBySelectedTask() {
  //   // Find the task by matching the selected task name
  //   TaskList? selectedTaskDetails = taskList.firstWhere(
  //         (task) => task.subject == selectedTask,
  //     orElse: () => null, // Return null if not found
  //   );
  //
  //   // Return the task ID if the task was found, otherwise return null
  //   return selectedTaskDetails.name;
  // }

  String? getTaskIdBySelectedTask() {
    // Find the task by matching the selected task name
    TaskList? selectedTaskDetails = taskList.firstWhere(
            (task) => task.subject == selectedTask
    );

    // Return the task ID if the task was found, otherwise return null
    return selectedTaskDetails.name;
  }


  double calculateTotalHours() {
    if (_toTime.isBefore(_fromTime)) {
      // Log error or throw exception
      return 0.0; // Return 0.0 if toTime is before fromTime
    }

    Duration duration = _toTime.difference(_fromTime);

    // Calculate total hours in decimal form
    double totalHours = duration.inHours + duration.inMinutes.remainder(60) / 60.0;

    // Format the result to two decimal places and clamp to non-negative values
    _hours = double.parse(totalHours.toStringAsFixed(2)).clamp(0.0, double.infinity);
    return _hours;

  }



  void setActivityType(String value) {
    _activityType = value;
    notifyListeners();
  }

  void setTask(TaskList value) {
    selectedTask = value;
    _task = value.name!;
    notifyListeners();
  }

  void setHours(String value) {
    _hours = double.tryParse(value) ?? 0.0;
    hoursController.text = _hours.toString();
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    descriptionController.text = _description;
    notifyListeners();
  }

  void setFromTime(DateTime value) {
    _fromTime = value;
    fromTimeController.text = "${"${fromTime.toLocal()}".split(' ')[0]} ${fromTime.hour}:${fromTime.minute.toString().padLeft(2, '0')}";
    notifyListeners();
  }

  void setToTime(DateTime value) {
    _toTime = value;
    toTimeController.text = "${"${toTime.toLocal()}".split(' ')[0]} ${toTime.hour}:${toTime.minute.toString().padLeft(2, '0')}";
    hoursController.text=calculateTotalHours().toString();
    notifyListeners();
  }

  void setProject(String value) {
    _project = value;
    projectController.text = value;
    notifyListeners();
  }

  TimeLog get timeLog => TimeLog(
    activityType: activityType,
    task: task,
    hours: hours,
    fromTime: fromTime,
    toTime: toTime,
    project: project,
    description: description,
  );

  @override
  void dispose() {
    // Dispose all controllers to free up resources
    projectController.dispose();
    descriptionController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    hoursController.dispose();
    _isDisposed = true; // Set the flag when disposed
    super.dispose();
  }

}
