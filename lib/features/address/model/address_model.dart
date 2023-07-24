
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
  String? image;
  String? title;
  DateTime? createdAt;

  AddressItem({this.id, this.image, this.title, this.createdAt});

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    createdAt = json['created_at'] != null ?DateTime.parse(json['created_at']) : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    if (createdAt != null) {
      data['created_at'] = createdAt ;
    }
    return data;
  }
}
