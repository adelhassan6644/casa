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
      return !provider.isLoading
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Styles.WHITE_COLOR,
                  border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
              child: TableCalendar(
                firstDay: provider.kFirstDay,
                lastDay: provider.kLastDay,
                headerStyle: const HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  headerPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  formatButtonVisible: false,
                ),
                focusedDay: provider.focusedDay,
                selectedDayPredicate: (day) => isSameDay(provider.day, day),
                calendarFormat: provider.calendarFormat,
                eventLoader: provider.loadSchedule,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, dynamic event) {
                  if (event.isNotEmpty) {
                    return Container(
                      width: 35,
                      decoration: BoxDecoration(
                          color: Styles.PRIMARY_COLOR.withOpacity(0.2),
                          shape: BoxShape.circle),
                    );
                  }
                  return null;
                }),
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: true,
                    selectedDecoration: const BoxDecoration(
                        color: Styles.PRIMARY_COLOR, shape: BoxShape.circle),
                    markerDecoration: const BoxDecoration(
                        color: Styles.PRIMARY_COLOR, shape: BoxShape.circle),
                    rangeHighlightColor: Theme.of(context).primaryColor),
                onDaySelected: (v1, v2) => provider.onDaySelected(v1, v2, id),
                onFormatChanged: provider.onChangeFormat,
                onPageChanged: (v) {
                  provider.focusedDay = v;
                },
                onCalendarCreated: (v) {
                  Future.delayed(Duration(milliseconds: 10),(){
                    provider.onDaySelected(DateTime.now(), DateTime.now(), id);
                  });
                }


              ),
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
