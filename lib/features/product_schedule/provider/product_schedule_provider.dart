import 'dart:collection';

import 'package:casa/features/product_schedule/repo/product_schedule_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/schedule_model.dart';

class ProductScheduleProvider extends ChangeNotifier {
  ProductScheduleRepo repo;
  ProductScheduleProvider({required this.repo});

  CalendarFormat calendarFormat = CalendarFormat.month;
  onChangeFormat(v) {
    calendarFormat = v;
    notifyListeners();
  }

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  List loadSchedule(DateTime day) {
    final kEventSource = {
      for (var item in productScheduleModel!)
        item.startTime!: List.generate(
            item.startTime!.day, (index) => ('Event $item | ${index + 1}'))
    };
    final kEvents = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(kEventSource);
    return kEvents[day] ?? [];
  }

  DateTime day = DateTime.now();
  DateTime focusedDay = DateTime.now();
  void onDaySelected(DateTime selectedDay, DateTime fDay, int id) {
    if (!isSameDay(day, selectedDay)) {
      day = selectedDay;
      focusedDay = fDay;
      notifyListeners();
      getDaySchedule(id);
    }
  }

  List<ScheduleModel>? productScheduleModel;
  bool isLoading = false;
  getProductSchedule(id) async {
    try {
      isLoading = true;
      productScheduleModel?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getProductSchedule(id);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["data"] != null && success.data["data"] != []) {
          productScheduleModel = List<ScheduleModel>.from(
              success.data["data"].map((x) => ScheduleModel.fromJson(x)));
        }
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      productScheduleModel?.clear();
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  List<ScheduleModel>? dayScheduleModel;
  bool isGetting = false;
  getDaySchedule(id) async {
    try {
      isGetting = true;
      dayScheduleModel?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getDaySchedule(id: id, day: day);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["data"] != null && success.data["data"] != []) {
          dayScheduleModel = List<ScheduleModel>.from(
              success.data["data"].map((x) => ScheduleModel.fromJson(x)));
        }
      });
      isGetting = false;
      notifyListeners();
    } catch (e) {
      dayScheduleModel?.clear();
      isGetting = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }


  ScheduleModel? selectedSchedule;
  onSelectSchedule(v){
    selectedSchedule = v;
    notifyListeners();
  }
}
