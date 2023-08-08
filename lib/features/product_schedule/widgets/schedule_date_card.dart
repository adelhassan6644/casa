import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/product_schedule/model/schedule_model.dart';
import 'package:flutter/cupertino.dart';
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
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL.h,
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF5F5F5),
                  border: Border.all(
                    color: const Color(0xFFF5F5F5),
                  )),
              child: Column(
                children: [
                  Text("من",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text(
                      scheduleModel?.startTime?.dateFormat(format: "hh:mm a") ?? "",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text("إلى",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                  Text(scheduleModel?.endTime?.dateFormat(format: "hh:mm a") ?? "",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 16, color: Styles.PRIMARY_COLOR)),
                ],
              )),
        );
      }
    );
  }
}
