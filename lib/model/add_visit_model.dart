class AddVisitModel {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? customer;
  String? customerName;
  String? date;
  String? time;
  String? visitType;
  String? description;
  String? employee;
  String? user;
  String? doctype;

  AddVisitModel(
      {this.name,
        this.owner,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.customer,
        this.customerName,
        this.date,
        this.time,
        this.visitType,
        this.description,
        this.employee,
        this.user,
        this.doctype});

  AddVisitModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    customer = json['customer'];
    customerName = json['customer_name'];
    date = json['date'];
    time = json['time'];
    visitType = json['visit_type'];
    description = json['description'];
    employee = json['employee'];
    user = json['user'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['visit_type'] = this.visitType;
    data['description'] = this.description;
    data['employee'] = this.employee;
    data['user'] = this.user;
    data['doctype'] = this.doctype;
    return data;
  }
}
