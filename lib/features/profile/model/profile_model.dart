class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? gender;
  DateTime? createdAt;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.gender,
      this.createdAt});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        gender:
            json["gender"] != null ? int.parse(json["gender"].toString()) : 0,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "gender": gender,
        "created_at": createdAt?.toIso8601String(),
      };
}
