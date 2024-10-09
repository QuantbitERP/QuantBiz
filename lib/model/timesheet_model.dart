class TimesheetDetails {
  final String name;
  final String creation;
  final String modified;
  final String modifiedBy;
  final String owner;
  final String docstatus;
  final String title;
  final String namingSeries;
  final String company;
  final String? customer;
  final String currency;
  final double exchangeRate;
  final String? salesInvoice;
  final String status;
  final String? parentProject;
  final String? employee;
  final String? employeeName;
  final String? department;
  final String? user;
  final String startDate;
  final String endDate;
  final double totalHours;
  final double totalBillableHours;
  final double baseTotalBillableAmount;
  final double baseTotalBilledAmount;
  final double baseTotalCostingAmount;
  final double totalBilledHours;
  final double totalBillableAmount;
  final double totalBilledAmount;
  final double totalCostingAmount;
  final double perBilled;
  final String? note;
  final String? customProjectName;

  TimesheetDetails({
    required this.name,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.owner,
    required this.docstatus,
    required this.title,
    required this.namingSeries,
    required this.company,
    this.customer,
    required this.currency,
    required this.exchangeRate,
    this.salesInvoice,
    required this.status,
    this.parentProject,
    this.employee,
    this.employeeName,
    this.department,
    this.user,
    required this.startDate,
    required this.endDate,
    required this.totalHours,
    required this.totalBillableHours,
    required this.baseTotalBillableAmount,
    required this.baseTotalBilledAmount,
    required this.baseTotalCostingAmount,
    required this.totalBilledHours,
    required this.totalBillableAmount,
    required this.totalBilledAmount,
    required this.totalCostingAmount,
    required this.perBilled,
    this.note,
    this.customProjectName,
  });

  factory TimesheetDetails.fromJson(Map<String, dynamic> json) {
    return TimesheetDetails(
      name: json['name'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      owner: json['owner'],
      docstatus: json['docstatus'].toString(),
      title: json['title'] ?? '',
      namingSeries: json['naming_series'],
      company: json['company'],
      customer: json['customer'],
      currency: json['currency'],
      exchangeRate: json['exchange_rate'].toDouble(),
      salesInvoice: json['sales_invoice'],
      status: json['status'],
      parentProject: json['parent_project'],
      employee: json['employee'],
      employeeName: json['employee_name'],
      department: json['department'],
      user: json['user'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalHours: json['total_hours'].toDouble(),
      totalBillableHours: json['total_billable_hours'].toDouble(),
      baseTotalBillableAmount: json['base_total_billable_amount'].toDouble(),
      baseTotalBilledAmount: json['base_total_billed_amount'].toDouble(),
      baseTotalCostingAmount: json['base_total_costing_amount'].toDouble(),
      totalBilledHours: json['total_billed_hours'].toDouble(),
      totalBillableAmount: json['total_billable_amount'].toDouble(),
      totalBilledAmount: json['total_billed_amount'].toDouble(),
      totalCostingAmount: json['total_costing_amount'].toDouble(),
      perBilled: json['per_billed'].toDouble(),
      note: json['note'],
      customProjectName: json['custom_project_name'],
    );
  }
}
