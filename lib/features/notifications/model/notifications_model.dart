class NotificationsModel {
  List<NotificationItem>? notifications;

  NotificationsModel({
    this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        notifications:
        json["data"] == null || json["data"]["notifications"] == null
            ? []
            : List<NotificationItem>.from(json["data"]["notifications"]!
            .map((x) => NotificationItem.fromJson(x))),
      );
}

class NotificationItem {
  NotificationData? notificationData;
  bool? isRead;
  String? id;
  int? notifiableId;

  NotificationItem({
    this.id,
    this.notifiableId,
    this.notificationData,
    this.isRead,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
          id: (json["id"]) ?? "'",
          notifiableId: json["notifiable_id"],
          notificationData: json["data"] == null
              ? null
              : NotificationData.fromJson(json["data"]),
          isRead: json["read_at"] == null ? false : true);

  Map<String, dynamic> toJson() =>
      {"id": id, "data": notificationData?.toJson(), "read_at": isRead};
}

class NotificationData {
  String? title;
  String? routName;
  bool? isMyOffer;
  String? message;
  int? status;
  int? id;
  String? url;

  NotificationData({
    this.message,
    this.routName,
    this.isMyOffer,
    this.title,
    this.status,
    this.id,
    this.url,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        message: json["message"],
        status: json["status"],
        title: json["title"],
        isMyOffer: json["is_my_offer"] ?? false,
        id: json["id"] != null ? int.tryParse(json["id"].toString()) : 0,
        routName: json["url"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "is_my_offer": isMyOffer,
    "status": status,
    "routName": url,
    "id": id,
    "title": title,
  };
}
