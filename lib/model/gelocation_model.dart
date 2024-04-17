class GeolocationModel {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? user;
  String? date;
  String? myLocation;
  String? deviceId;

  String? checkData;
  String? doctype;
  double? distance;
  List<LocationTable>? locationTable;

  GeolocationModel(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.user,
      this.date,
      this.deviceId,
      this.myLocation,
      this.checkData,
      this.doctype,
      this.distance,
      this.locationTable});

  GeolocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    user = json['user'];
    date = json['date'];
    deviceId=json['device_id'];
    myLocation = json['my_location'];
    checkData = json['check_data'];
    distance=json['distance'];
    doctype = json['doctype'];
    if (json['location_table'] != null) {
      locationTable = <LocationTable>[];
      json['location_table'].forEach((v) {
        locationTable!.add(LocationTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['user'] = user;
    data['date'] = date;
    data['device_id']=deviceId;
    data['my_location'] = myLocation;
    data['check_data'] = checkData;
    data['distance']=distance;
    data['doctype'] = doctype;
    if (locationTable != null) {
      data['location_table'] =
          locationTable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationTable {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? longitude;
  String? latitude;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  LocationTable(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.longitude,
      this.latitude,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  LocationTable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
