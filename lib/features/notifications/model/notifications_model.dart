
class NotificationsModel {
  String? message;
  List<NotificationItem>? data;

  NotificationsModel({this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationItem>[];
      json['data'].forEach((v) {
        data!.add(NotificationItem.fromJson(v));
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

class NotificationItem {
  int? id;
  int? reservationId;
  String? image;
  String? title;
  DateTime? createdAt;

  NotificationItem({this.id,this.reservationId, this.image, this.title, this.createdAt});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    image = json['image'];
    title = json['title'];
    createdAt = json['created_at'] != null ?DateTime.parse(json['created_at']) : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reservation_id'] = reservationId;
    data['image'] = image;
    data['title'] = title;
    if (createdAt != null) {
      data['created_at'] = createdAt ;
    }
    return data;
  }
}
