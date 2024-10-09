class EmpData {
  String? employee;
  String? empName;
  String? email;
  String? company;
  String? employeeImage;

  EmpData({this.employee,this.empName, this.email, this.company, this.employeeImage});

  EmpData.fromJson(Map<String, dynamic> json) {
    employee = json['employee'];
    empName = json['emp_name'];
    email = json['email'];
    company = json['company'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['emp_name'] = empName;
    data['email'] = email;
    data['company'] = company;
    data['employee_image'] = employeeImage;
    return data;
  }
}
