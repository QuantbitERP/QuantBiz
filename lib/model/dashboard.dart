class DashBoard {
  List<LeaveBalance>? leaveBalance;
  String? lastLogType;
  AttendanceDetails? attendanceDetails;
  String? empName;
  String? email;
  String? company;
  String? lastLogTime;
  String? employeeImage;

  DashBoard(
      {this.leaveBalance,
        this.lastLogType,
        this.attendanceDetails,
        this.email,
        this.empName,
        this.company,
        this.lastLogTime,
        this.employeeImage});

  DashBoard.fromJson(Map<String, dynamic> json) {
    if (json['leave_balance'] != null) {
      leaveBalance = <LeaveBalance>[];
      json['leave_balance'].forEach((v) {
        leaveBalance!.add(LeaveBalance.fromJson(v));
      });
    }
    lastLogType = json['last_log_type'];
    attendanceDetails = json['attendance_details'] != null
        ? AttendanceDetails.fromJson(json['attendance_details'])
        : null;
    empName = json['emp_name'];
    company = json['company'];
    email=json['email'];
    lastLogTime = json['last_log_time'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (leaveBalance != null) {
      data['leave_balance'] =
          leaveBalance!.map((v) => v.toJson()).toList();
    }
    data['last_log_type'] = lastLogType;
    if (attendanceDetails != null) {
      data['attendance_details'] = attendanceDetails!.toJson();
    }
    data['emp_name'] = empName;
    data['company'] = company;
    data['email']=email;
    data['last_log_time'] = lastLogTime;
    data['employee_image'] = employeeImage;
    return data;
  }
}

class LeaveBalance {
  String? leaveType;
  String? employee;
  String? employeeName;
  double? leavesAllocated;
  double? leavesExpired;
  double? openingBalance;
  double? leavesTaken;
  double? closingBalance;
  int? indent;

  LeaveBalance(
      {this.leaveType,
        this.employee,
        this.employeeName,
        this.leavesAllocated,
        this.leavesExpired,
        this.openingBalance,
        this.leavesTaken,
        this.closingBalance,
        this.indent});

  LeaveBalance.fromJson(Map<String, dynamic> json) {
    leaveType = json['leave_type'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    leavesAllocated = json['leaves_allocated'];
    leavesExpired = json['leaves_expired'];
    openingBalance = json['opening_balance'];
    leavesTaken = json['leaves_taken'];
    closingBalance = json['closing_balance'];
    indent = json['indent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['leave_type'] = leaveType;
    data['employee'] = employee;
    data['employee_name'] = employeeName;
    data['leaves_allocated'] = leavesAllocated;
    data['leaves_expired'] = leavesExpired;
    data['opening_balance'] = openingBalance;
    data['leaves_taken'] = leavesTaken;
    data['closing_balance'] = closingBalance;
    data['indent'] = indent;
    return data;
  }
}

class AttendanceDetails {
  String? monthTitle;
  int? tillDays;
  int? totalDays;
  double? dayOff;
  double? present;
  double? absent;

  AttendanceDetails(
      {this.monthTitle,
        this.tillDays,
        this.totalDays,
        this.dayOff,
        this.present,
        this.absent});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    monthTitle = json['month_title'];
    tillDays = json['till_days'];
    totalDays = json['total_days'];
    dayOff = json['day off'];
    present = json['present'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_title'] = monthTitle;
    data['till_days'] = tillDays;
    data['total_days'] = totalDays;
    data['day off'] = dayOff;
    data['present'] = present;
    data['absent'] = absent;
    return data;
  }
}