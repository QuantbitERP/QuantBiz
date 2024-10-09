class EmployeeDetails {
  String? employeeName;
  String? designation;
  String? name;
  String? dateOfJoining;
  String? dateOfBirth;
  String? gender;
  String? companyEmail;
  String? personalEmail;
  String? cellNumber;
  String? emergencyPhoneNumber;
  String? employeeImage;
  String? company;

  EmployeeDetails(
      {this.employeeName,
        this.designation,
        this.name,
        this.dateOfJoining,
        this.dateOfBirth,
        this.gender,
        this.companyEmail,
        this.personalEmail,
        this.cellNumber,
        this.emergencyPhoneNumber,
        this.employeeImage,
        this.company
      });

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    employeeName = json['employee_name'];
    designation = json['designation'];
    name = json['name'];
    dateOfJoining = json['date_of_joining'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    companyEmail = json['company_email'];
    personalEmail = json['personal_email'];
    cellNumber = json['cell_number'];
    emergencyPhoneNumber = json['emergency_phone_number'];
    employeeImage = json['employee_image'];
    company = json["company"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employee_name'] = employeeName;
    data['designation'] = designation;
    data['name'] = name;
    data['date_of_joining'] = dateOfJoining;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['company_email'] = companyEmail;
    data['personal_email'] = personalEmail;
    data['cell_number'] = cellNumber;
    data['emergency_phone_number'] = emergencyPhoneNumber;
    data['employee_image'] = employeeImage;
    return data;
  }
}
