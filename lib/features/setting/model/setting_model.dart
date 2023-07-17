class SettingModel {
  String? message;
  Data? data;

  SettingModel({this.message, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? terms;
  String? name;
  String? email;
  String? twitter;
  String? website;
  String? instagram;
  String? facebook;
  String? tiktok;
  String? image;
  String? phone;
  String? aboutUs;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.terms,
      this.name,
      this.email,
      this.twitter,
      this.website,
      this.instagram,
      this.facebook,
      this.tiktok,
      this.image,
      this.phone,
      this.aboutUs,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    terms = json['terms'];
    email = json['email'];
    twitter = json['twitter'];
    website = json['website'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    tiktok = json['tiktok'];
    image = json['image'];
    phone = json['phone'];
    aboutUs = json['aboutUs'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['terms'] = terms;
    data['name'] = this.name;
    data['email'] = this.email;
    data['twitter'] = this.twitter;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['tiktok'] = this.tiktok;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['aboutUs'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
