class VisitListModel {
  String? name;
  String? customerName;
  String? date;
  String? time;
  String? visitType;

  VisitListModel(
      {this.name, this.customerName, this.date, this.time, this.visitType});

  VisitListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    date = json['date'];
    time = json['time'];
    visitType = json['visit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['date'] = date;
    data['time'] = time;
    data['visit_type'] = visitType;
    return data;
  }
}
