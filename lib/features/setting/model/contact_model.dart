class ContactModel {
  int? id;
  String? name;
  String? email;
  String? twitter;
  String? website;
  String? instagram;
  String? facebook;
  String? tiktok;
  String? image;
  String? phone;
  String? whatsapp;
  String? aboutUs;

  ContactModel(
      {this.id,
      this.name,
      this.email,
      this.twitter,
      this.website,
      this.instagram,
      this.facebook,
      this.tiktok,
      this.image,
      this.phone,
      this.whatsapp,
      this.aboutUs});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    twitter = json['twitter'];
    website = json['website'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    tiktok = json['tiktok'];
    image = json['image'];
    phone = json['phone'];
    aboutUs = json['aboutUs'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['twitter'] = twitter;
    data['website'] = website;
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['tiktok'] = tiktok;
    data['image'] = image;
    data['phone'] = phone;
    data['whatsapp'] = whatsapp;
    data['aboutUs'] = aboutUs;
    return data;
  }
}
