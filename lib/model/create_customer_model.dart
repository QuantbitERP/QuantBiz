class CreateCustomer {
  String? name;
  String? customerName;
  String? customerType;
  String? customerGroup;
  String? territory;
  String? gstCategory;
  String? gstin;
  String? emailId;
  String? mobileNo;
  String? contactId;
  Billing? billing;
  Shipping? shipping;

  CreateCustomer(
      {this.name,
        this.customerName,
        this.customerType,
        this.customerGroup,
        this.territory,
        this.gstCategory,
        this.gstin,
        this.emailId,
        this.mobileNo,
        this.contactId,
        this.billing,
        this.shipping});

  CreateCustomer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    customerType = json['customer_type'];
    customerGroup = json['customer_group'];
    territory = json['territory'];
    gstCategory = json['gst_category'];
    gstin = json['gstin'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    contactId = json['contact_id'];
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['customer_name'] = this.customerName;
    data['customer_type'] = this.customerType;
    data['customer_group'] = this.customerGroup;
    data['territory'] = this.territory;
    data['gst_category'] = this.gstCategory;
    data['gstin'] = this.gstin;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['contact_id'] = this.contactId;
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    return data;
  }
}

class Billing {
  String? billingId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;
  String? country;

  Billing(
      {this.billingId,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.pincode,
        this.country});

  Billing.fromJson(Map<String, dynamic> json) {
    billingId = json['billing_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billing_id'] = this.billingId;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    return data;
  }
}

class Shipping {
  String? shippingId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;
  String? country;

  Shipping(
      {this.shippingId,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.pincode,
        this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    shippingId = json['shipping_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipping_id'] = this.shippingId;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    return data;
  }
}
