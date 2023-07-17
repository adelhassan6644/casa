import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class Methods {
  static diffBtw2Dates({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    var dur = endDate.toLocal().difference(startDate);
    return dur.inDays.toString();
  }

  static WeekdayCount getWeekdayCount(
      {required DateTime startDate,
      required DateTime endDate,
      required List weekdays}) {
    int count = 0;
    int days = 0;
    List<DateTime> daysList = [];

    for (int weekday in weekdays) {
      DateTime currentDate = startDate;
      int daysToWeekday = ((weekday - startDate.weekday) + 7) % 7;

      if (daysToWeekday == 0) {
        daysList.add(startDate);
        count += 1;
        days += 1;
      }

      currentDate = currentDate.add(Duration(days: daysToWeekday));

      while (currentDate.isBefore(endDate)) {
        if (currentDate.weekday == weekday) {
          daysList.add(currentDate);
          count += 1;
          days += 1;
        }
        currentDate = currentDate.add(const Duration(days: 7));
      }
    }
    return WeekdayCount(count, days, daysList);
  }

  static convertStringToTime(timeString, {bool withFormat = false}) {
    List<String> parts = timeString.split(':');
    TimeOfDay timeOfDay =
        TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
      now.second,
    );
    if (withFormat) {
      return dateTime
          .dateFormat(format: "mm : hh aa")
          .replaceAll("AM", "صباحاً")
          .replaceAll("PM", "مساءً");
    } else {
      return dateTime;
    }
  }

  static convertStringToDataTime(timeString) {
    List<String> parts = timeString.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      0,
      0,
      0,
    );
  }

  static getDayCount({
    required DateTime date,
  }) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inSeconds < 5) {
      return "الآن";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds} ثانية";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} دقيقة";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ساعة";
    } else if (difference.inDays < 30) {
      return '${difference.inDays} يوم';
    } else {
      return date.defaultFormat();
    }
  }

  static calcDistance(
      {required lat1, required long1, required lat2, required long2}) {
    return (Geolocator.distanceBetween(double.parse(lat1), double.parse(long1),
                double.parse(lat2), double.parse(long2)) /
            1000)
        .toStringAsFixed(2);
  }
}

class WeekdayCount {
  final int count;
  final int days;
  final List<DateTime> daysList;

  WeekdayCount(this.count, this.days, this.daysList);
  @override
  String toString() {
    return "cont: $count -- days:$daysList  ";
  }
}
