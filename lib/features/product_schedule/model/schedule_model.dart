class ScheduleModel {
  int? id;
  String? duration;
  DateTime? startTime;
  DateTime? endTime;
  String? service;
  String? subService;
  bool? isReserved;

  ScheduleModel({
    this.id,
    this.duration,
    this.startTime,
    this.endTime,
    this.service,
    this.subService,
    this.isReserved,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        duration: json["duration"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        service: json["service"],
        subService: json["subService"],
        isReserved: json["is_reserved"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "service": service,
        "subService": subService,
        "is_reserved": isReserved,
      };
}
