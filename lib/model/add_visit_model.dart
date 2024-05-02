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
  String? latitude;
  String? location;
  String? longitude;
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
        this.location,
        this.user,
        this.latitude,
        this.longitude,
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
    location=json['location'];
    user = json['user'];
    longitude=json['longitude'];
    latitude=json['latitude'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['date'] = date;
    data['time'] = time;
    data['visit_type'] = visitType;
    data['description'] = description;
    data['location']=location;
    data['employee'] = employee;
    data['latitude']=latitude;
    data['longitude']=longitude;
    data['user'] = user;
    data['doctype'] = doctype;
    return data;
  }
}
