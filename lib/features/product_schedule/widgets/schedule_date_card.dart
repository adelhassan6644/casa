import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/product_schedule/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../provider/product_schedule_provider.dart';

class ScheduleDateCard extends StatelessWidget {
  const ScheduleDateCard({Key? key, this.scheduleModel}) : super(key: key);
  final ScheduleModel? scheduleModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
      return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if ( provider.selectedSchedule?.id != scheduleModel?.id) {
            provider.onSelectSchedule(scheduleModel);
          } else {
            provider.onSelectSchedule(null);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL.h,
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: provider.selectedSchedule?.id == scheduleModel?.id
                      ? const Color(0xFFF2F0E6)
                      : const Color(0xFFF5F5F5),
                  border: Border.all(
                    color: provider.selectedSchedule?.id == scheduleModel?.id
                        ? Styles.DETAILS_COLOR
                        : const Color(0xFFF5F5F5),
                  )),
              child: Column(
                children: [
                  if(scheduleModel!.isReserved!)
                  Text(

                          "غير متاح للحجز",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 12, color: Styles.IN_ACTIVE)),
                  Text("من",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text(
                      scheduleModel?.startTime?.dateFormat(format: "hh:mm a") ??
                          "",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text("إلى",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text(
                      scheduleModel?.endTime?.dateFormat(format: "hh:mm a") ??
                          "",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                ],
              )),
        ),
      );
    });
  }
}
