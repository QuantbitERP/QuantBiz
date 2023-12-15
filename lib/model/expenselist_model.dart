class Expenselist {
  String? name;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? namingSeries;
  String? employee;
  String? employeeName;
  String? department;
  String? expenseApprover;
  String? approvalStatus;
  int? isPaid;
  double? totalSanctionedAmount;
  double? totalTaxesAndCharges;
  double? totalAdvanceAmount;
  double? grandTotal;
  double? totalClaimedAmount;
  double? totalAmountReimbursed;
  
  String? postingDate;
  String? title;
  String? payableAccount;
  String? costCenter;
  String? status;
  String? expenseType;
  String? expenseDescription;
  String? expenseDate;
  List<Attachments>? attachments;

  Expenselist(
      {this.name,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.idx,
        this.namingSeries,
        this.employee,
        this.employeeName,
        this.department,
        this.expenseApprover,
        this.approvalStatus,
        this.isPaid,
        this.totalSanctionedAmount,
        this.totalTaxesAndCharges,
        this.totalAdvanceAmount,
        this.grandTotal,
        this.totalClaimedAmount,
        this.totalAmountReimbursed,
        this.postingDate,
        this.title,
        this.payableAccount,
        this.costCenter,
        this.status,
        this.expenseType,
        this.expenseDescription,
        this.expenseDate,
        this.attachments});

  Expenselist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    department = json['department'];
    expenseApprover = json['expense_approver'];
    approvalStatus = json['approval_status'];
    isPaid = json['is_paid'];
    totalSanctionedAmount = json['total_sanctioned_amount'];
    totalTaxesAndCharges = json['total_taxes_and_charges'];
    totalAdvanceAmount = json['total_advance_amount'];
    grandTotal = json['grand_total'];
    totalClaimedAmount = json['total_claimed_amount'];
    totalAmountReimbursed = json['total_amount_reimbursed'];
    postingDate = json['posting_date'];
    title = json['title'];
    payableAccount = json['payable_account'];
    costCenter = json['cost_center'];
    status = json['status'];
    expenseType = json['expense_type'];
    expenseDescription = json['expense_description'];
    expenseDate = json['expense_date'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['naming_series'] = this.namingSeries;
    data['employee'] = this.employee;
    data['employee_name'] = this.employeeName;
    data['department'] = this.department;
    data['expense_approver'] = this.expenseApprover;
    data['approval_status'] = this.approvalStatus;
    data['is_paid'] = this.isPaid;
    data['total_sanctioned_amount'] = this.totalSanctionedAmount;
    data['total_taxes_and_charges'] = this.totalTaxesAndCharges;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['grand_total'] = this.grandTotal;
    data['total_claimed_amount'] = this.totalClaimedAmount;
    data['total_amount_reimbursed'] = this.totalAmountReimbursed;
    data['posting_date'] = this.postingDate;
    data['title'] = this.title;
    data['payable_account'] = this.payableAccount;
    data['cost_center'] = this.costCenter;
    data['status'] = this.status;
    data['expense_type'] = this.expenseType;
    data['expense_description'] = this.expenseDescription;
    data['expense_date'] = this.expenseDate;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  String? fileUrl;

  Attachments({this.fileUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = this.fileUrl;
    return data;
  }
}
