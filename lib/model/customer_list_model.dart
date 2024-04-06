class CustomerList {
  String? name;
  String? customerName;
  String? customerGroup;
  String? territory;
  String? gstCategory;

  CustomerList(
      {this.name,
        this.customerName,
        this.customerGroup,
        this.territory,
        this.gstCategory});

  CustomerList.fromJson(Map<String, dynamic> json) {
    name=json['name'];
    customerName = json['customer_name'];
    customerGroup = json['customer_group'];
    territory = json['territory'];
    gstCategory = json['gst_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name']=name;
    data['customer_name'] = customerName;
    data['customer_group'] = customerGroup;
    data['territory'] = territory;
    data['gst_category'] = gstCategory;
    return data;
  }
}
