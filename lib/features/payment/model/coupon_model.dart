class CouponModel {
  CouponModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.amount,
    required this.endAt,
    required this.type,
    required this.uses,
    required this.max,
    required this.userId,
    required this.eventId,
    required this.status,
  });
  late final int id;
  late final String createdAt;
  late final String updatedAt;
  late final String code;
  late final double amount;
  late final String endAt;
  late final String type;
  late final int? uses;
  late final double? max;
  late final int? userId;
  late final int? eventId;
  late final int? status;

  CouponModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    code = json['code'];
    amount = double.parse(json['amount'].toString());

    type = json['type']??"presntage";

    max = json['max'].toDouble();

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['code'] = code;
    _data['amount'] = amount;
    _data['end_at'] = endAt;
    _data['type'] = type;
    _data['uses'] = uses;
    _data['max'] = max;
    _data['user_id'] = userId;
    _data['event_id'] = eventId;
    _data['status'] = status;
    return _data;
  }
}