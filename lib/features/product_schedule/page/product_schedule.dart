import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/product_schedule/provider/product_schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../widgets/schedule_date_widget.dart';

class ProductSchedule extends StatefulWidget {
  const ProductSchedule({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  State<ProductSchedule> createState() => _ProductScheduleState();
}

class _ProductScheduleState extends State<ProductSchedule> {
  @override
  void initState() {
    sl<ProductScheduleProvider>().day = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.SCAFFOLD_BG,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "حجز جلسة ${widget.data["title"]}",
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: ListAnimator(data: [
                    TableCalendar(
                      firstDay: provider.kFirstDay,
                      lastDay: provider.kLastDay,
                      focusedDay: provider.focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(provider.day, day),
                      calendarFormat: provider.calendarFormat,
                      eventLoader: provider.loadSchedule,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                          outsideDaysVisible: true,
                          selectedDecoration: const BoxDecoration(
                              color: Styles.PRIMARY_COLOR,
                              shape: BoxShape.circle),
                          markerDecoration: const BoxDecoration(
                              color: Styles.PRIMARY_COLOR,
                              shape: BoxShape.circle),
                          rangeHighlightColor: Theme.of(context).primaryColor),
                      onDaySelected: (v1, v2) =>
                          provider.onDaySelected(v1, v2, widget.data["id"]),
                      weekendDays: const [DateTime.friday, DateTime.thursday],
                      onFormatChanged: provider.onChangeFormat,
                      onPageChanged: (v) {
                        provider.focusedDay = v;
                      },
                      onCalendarCreated: (v) {},
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    !provider.isGetting
                        ? Visibility(
                            visible: provider.dayScheduleModel != null &&
                                provider.dayScheduleModel != null &&
                                provider.dayScheduleModel!.isNotEmpty,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Styles.WHITE_COLOR,
                                    border: Border.all(
                                        color: Styles.LIGHT_BORDER_COLOR)),
                                child: Column(
                                  children: [
                                    Text(
                                        "${provider.day?.dateFormat(format: "EEEE", lang: "ar")} ${provider.day?.dateFormat(format: "dd/MM")}",
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 18,
                                            color: Styles.PRIMARY_COLOR)),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Wrap(
                                          direction: Axis.horizontal,
                                          spacing: 12,
                                          runSpacing: 16,
                                          children: List.generate(
                                              provider.dayScheduleModel
                                                      ?.length ??
                                                  0,
                                              (index) => ScheduleDateWidget(
                                                    scheduleModel: provider
                                                            .dayScheduleModel?[
                                                        index],
                                                  ))),
                                    ),
                                    Text(
                                        "مدة الجلسة ${provider.dayScheduleModel?.length != 0 ? provider.dayScheduleModel?.first.duration ?? "" : 0}",
                                        style: AppTextStyles.regular.copyWith(
                                            fontSize: 14,
                                            color: Styles.DETAILS_COLOR)),
                                  ],
                                )),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.h,
                            ),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Styles.WHITE_COLOR,
                                    border: Border.all(
                                        color: Styles.LIGHT_BORDER_COLOR)),
                                child: Column(
                                  children: [
                                    CustomShimmerContainer(
                                      width: context.width,
                                      height: 16.h,
                                      radius: 100,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Row(children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions
                                                    .PADDING_SIZE_SMALL.h),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Styles
                                                            .LIGHT_BORDER_COLOR,
                                                        width: 1.h))),
                                            child: CustomShimmerContainer(
                                              width: context.width,
                                              height: 100.h,
                                              radius: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions
                                                    .PADDING_SIZE_SMALL.h),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Styles
                                                            .LIGHT_BORDER_COLOR,
                                                        width: 1.h))),
                                            child: CustomShimmerContainer(
                                              width: context.width,
                                              height: 100.h,
                                              radius: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions
                                                    .PADDING_SIZE_SMALL.h),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Styles
                                                            .LIGHT_BORDER_COLOR,
                                                        width: 1.h))),
                                            child: CustomShimmerContainer(
                                              width: context.width,
                                              height: 100.h,
                                              radius: 15,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    CustomShimmerContainer(
                                      width: context.width,
                                      height: 12.h,
                                      radius: 100,
                                    ),
                                  ],
                                )),
                          ),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: CustomButton(
                  text: getTranslated("book_the_appointment", context),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
