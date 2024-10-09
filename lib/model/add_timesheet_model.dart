class Timesheet {
  String name; // Leave empty for new timesheets
  String employee; // Will be overwritten by employee associated with the current user
  String company; // Will be overwritten by the employee's company
  DateTime startDate;
  DateTime endDate;
  List<TimeLog> timeLogs;
  String status; // Draft or leave empty if submitted on creation
  String remarks;

  Timesheet({
    required this.name,
    required this.employee,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.timeLogs,
    required this.status,
    required this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'employee': employee,
      'company': company,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'time_logs': timeLogs.map((log) => log.toJson()).toList(),
      'status': status,
      'remarks': remarks,
    };
  }
}

class TimeLog {
  String activityType;
  String task;
  double hours;
  DateTime fromTime;
  DateTime toTime;
  String project;

  TimeLog({
    required this.activityType,
    required this.task,
    required this.hours,
    required this.fromTime,
    required this.toTime,
    required this.project,
  });

  Map<String, dynamic> toJson() {
    return {
      'activity_type': activityType,
      'task': task,
      'hours': hours,
      'from_time': fromTime.toIso8601String(),
      'to_time': toTime.toIso8601String(),
      'project': project,
    };
  }
}
