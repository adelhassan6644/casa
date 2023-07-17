class WeekModel {
  int? id;
  String? dayName;
  String? startTime;
  String? endTime;
  WeekModel({this.id, this.dayName, this.endTime, this.startTime});

  factory WeekModel.fromJson(Map<String, dynamic> json) => WeekModel(
        dayName: json["day"],
        id: json["day_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "day_id": id,
        "day": dayName,
        "start_time": startTime,
        "end_time": endTime,
      };
  // @override
  // String toString() {
  //
  //   return "$id -- $dayName  ";
  // }
}
