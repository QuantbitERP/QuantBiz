class TimesheetDetails {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? title;
  String? namingSeries;
  String? company;
  String? currency;
  double? exchangeRate;
  String? status;
  String? parentProject;
  String? employee;
  String? employeeName;
  String? startDate;
  String? endDate;
  double? totalHours;
  double? totalBillableHours;
  double? baseTotalBillableAmount;
  double? baseTotalBilledAmount;
  double? baseTotalCostingAmount;
  double? totalBilledHours;
  double? totalBillableAmount;
  double? totalBilledAmount;
  double? totalCostingAmount;
  double? perBilled;
  List<TimeLog>? timeLogs;

  TimesheetDetails({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.title,
    this.namingSeries,
    this.company,
    this.currency,
    this.exchangeRate,
    this.status,
    this.parentProject,
    this.employee,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.totalHours,
    this.totalBillableHours,
    this.baseTotalBillableAmount,
    this.baseTotalBilledAmount,
    this.baseTotalCostingAmount,
    this.totalBilledHours,
    this.totalBillableAmount,
    this.totalBilledAmount,
    this.totalCostingAmount,
    this.perBilled,
    this.timeLogs,
  });

  factory TimesheetDetails.fromJson(Map<String, dynamic> json) {
    return TimesheetDetails(
      name: json['name'],
      owner: json['owner'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      title: json['title'],
      namingSeries: json['naming_series'],
      company: json['company'],
      currency: json['currency'],
      exchangeRate: (json['exchange_rate'] as num?)?.toDouble(),
      status: json['status'],
      parentProject: json['parent_project'],
      employee: json['employee'],
      employeeName: json['employee_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalHours: (json['total_hours'] as num?)?.toDouble(),
      totalBillableHours: (json['total_billable_hours'] as num?)?.toDouble(),
      baseTotalBillableAmount: (json['base_total_billable_amount'] as num?)?.toDouble(),
      baseTotalBilledAmount: (json['base_total_billed_amount'] as num?)?.toDouble(),
      baseTotalCostingAmount: (json['base_total_costing_amount'] as num?)?.toDouble(),
      totalBilledHours: (json['total_billed_hours'] as num?)?.toDouble(),
      totalBillableAmount: (json['total_billable_amount'] as num?)?.toDouble(),
      totalBilledAmount: (json['total_billed_amount'] as num?)?.toDouble(),
      totalCostingAmount: (json['total_costing_amount'] as num?)?.toDouble(),
      perBilled: (json['per_billed'] as num?)?.toDouble(),
      timeLogs: (json['time_logs'] as List<dynamic>?)
          ?.map((timeLog) => TimeLog.fromJson(timeLog))
          .toList(),
    );
  }
}

class TimeLog {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? activityType;
  String? fromTime;
  String? toTime;
  double? hours;
  String? project;
  String? projectName;
  String? task;
  String? description;
  int? isBillable;
  double? billingHours;

  TimeLog({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.activityType,
    this.fromTime,
    this.toTime,
    this.hours,
    this.project,
    this.projectName,
    this.task,
    this.description,
    this.isBillable,
    this.billingHours,
  });

  factory TimeLog.fromJson(Map<String, dynamic> json) {
    return TimeLog(
      name: json['name'],
      owner: json['owner'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      activityType: json['activity_type'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
      hours: (json['hours'] as num?)?.toDouble(),
      project: json['project'],
      projectName: json['project_name'],
      task: json['task'],
      description: json['description'],
      isBillable: json['is_billable'],
      billingHours: (json['billing_hours'] as num?)?.toDouble(),
    );
  }
}
