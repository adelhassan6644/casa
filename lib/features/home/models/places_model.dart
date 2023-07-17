class PlacesModel {
  String? message;
  List<PlaceItem>? data;

  PlacesModel({this.message, this.data});

  PlacesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(PlaceItem.fromJson(v));
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

class PlaceItem {
  int? id;
  String? category;
  String? name;
  String? nameColor;
  String? phone;
  String? address;
  String? description;
  double? lat;
  double? long;
  int? status;
  int? agentId;
  int? categoryId;
  List<String>? images;
  String? image;
  String? twitter;
  String? whatsapp;
  String? instagram;
  String? tiktok;
  String? facebook;
  String? createdAt;
  String? updatedAt;

  PlaceItem(
      {this.id,
      this.category,
      this.name,
      this.nameColor,
      this.phone,
      this.address,
      this.description,
      this.lat,
      this.long,
      this.status,
      this.agentId,
      this.categoryId,
      this.image,
      this.images,
      this.twitter,
      this.whatsapp,
      this.instagram,
      this.tiktok,
      this.facebook,
      this.createdAt,
      this.updatedAt});

  PlaceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    nameColor = json['name_color'];
    phone = json['phone'];
    address = json['address'];
    description = json['description'];
    lat = json['lat'] != null ? double.parse(json['lat'].toString()) : null;
    long = json['long'] != null ? double.parse(json['long'].toString()) : null;
    status = json['status'];
    agentId = json['agent_id'];
    categoryId = json['category_id'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    tiktok = json['tiktok'];
    facebook = json['facebook'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_color'] = nameColor;
    data['phone'] = phone;
    data['address'] = address;
    data['description'] = description;
    data['lat'] = lat;
    data['long'] = long;
    data['status'] = status;
    data['agent_id'] = agentId;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['image'] = images;
    data['twitter'] = twitter;
    data['whatsapp'] = whatsapp;
    data['instagram'] = instagram;
    data['tiktok'] = tiktok;
    data['facebook'] = facebook;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
