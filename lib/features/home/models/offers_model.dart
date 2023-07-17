class OffersModel {
  String? message;
  List<OfferItem>? data;

  OffersModel({this.message, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data!.add(OfferItem.fromJson(v));
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

class OfferItem {
  int? id;
  String? image;
  String? description;
  String? title;
  String? phone;
  int? status;
  int? type;
  int? agentId;
  String? createdAt;
  String? updatedAt;

  OfferItem(
      {this.id,
        this.image,
        this.description,
        this.title,
        this.phone,
        this.status,
        this.type,
        this.agentId,
        this.createdAt,
        this.updatedAt});

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    title = json['title'];
    phone = json['phone'];
    status = json['status'];
    type = json['type'];
    agentId = json['agent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['title'] = title;
    data['phone'] = phone;
    data['status'] = status;
    data['type'] = type;
    data['agent_id'] = agentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
