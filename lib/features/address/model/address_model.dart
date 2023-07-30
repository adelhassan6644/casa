class AddressesModel {
  String? message;
  List<AddressItem>? data;

  AddressesModel({this.message, this.data});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(AddressItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressItem {
  int? id;
  String? address;
  String? lat;
  String? long;
  int? type;

  AddressItem({this.id, this.address, this.type, this.lat, this.long});

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    type = json['type'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['type'] = type;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
