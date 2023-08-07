import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/core/utils/styles.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/product_schedule_provider.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
      return !provider.isGetting
          ? TableCalendar(
              firstDay: provider.kFirstDay,
              lastDay: provider.kLastDay,
              focusedDay: provider.focusedDay,
              selectedDayPredicate: (day) => isSameDay(provider.day, day),
              calendarFormat: provider.calendarFormat,
              eventLoader: provider.loadSchedule,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  selectedDecoration: const BoxDecoration(
                      color: Styles.PRIMARY_COLOR, shape: BoxShape.circle),
                  markerDecoration: const BoxDecoration(
                      color: Styles.PRIMARY_COLOR, shape: BoxShape.circle),
                  rangeHighlightColor: Theme.of(context).primaryColor),
              onDaySelected: (v1, v2) => provider.onDaySelected(v1, v2, id),
              weekendDays: const [DateTime.friday, DateTime.thursday],
              onFormatChanged: provider.onChangeFormat,
              onPageChanged: (v) {
                provider.focusedDay = v;
              },
              onCalendarCreated: (v) {},
            )
          : const _CalenderShimmer();
    });
  }
}

class _CalenderShimmer extends StatelessWidget {
  const _CalenderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmerContainer(
      width: context.width,
      height: 340,
      radius: 24,
    );
  }
}
