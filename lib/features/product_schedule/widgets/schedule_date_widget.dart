import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/features/product_schedule/provider/product_schedule_provider.dart';
import 'package:casa/features/product_schedule/widgets/schedule_date_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/shimmer/custom_shimmer.dart';

class ScheduleDateWidget extends StatelessWidget {
  const ScheduleDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
      return !provider.isGetting
          ? Visibility(
              visible: provider.dayScheduleModel != null &&
                  provider.dayScheduleModel != null &&
                  provider.dayScheduleModel!.isNotEmpty,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Styles.WHITE_COLOR,
                      border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${provider.day?.dateFormat(format: "EEEE", lang: "ar")} ${provider.day?.dateFormat(format: "dd/MM")}",
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18, color: Styles.PRIMARY_COLOR)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 12,
                            runSpacing: 16,
                            children: List.generate(
                                provider.dayScheduleModel?.length ?? 0,
                                (index) => ScheduleDateCard(
                                      scheduleModel:
                                          provider.dayScheduleModel?[index],
                                    ))),
                      ),
                      Text(
                          getTranslated("session_duration", context)+"${provider.dayScheduleModel?.length != 0 ? provider.dayScheduleModel?.first.duration ?? "" : 0}",
                          style: AppTextStyles.regular.copyWith(
                              fontSize: 14, color: Styles.DETAILS_COLOR)),
                    ],
                  )),
            )
          : const _ScheduleDateShimmer();
    });
  }
}

class _ScheduleDateShimmer extends StatelessWidget {
  const _ScheduleDateShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.h,
      ),
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Styles.WHITE_COLOR,
              border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmerContainer(
                width: 150,
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: Dimensions.PADDING_SIZE_SMALL.h),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.LIGHT_BORDER_COLOR,
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
                          bottom: Dimensions.PADDING_SIZE_SMALL.h),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.LIGHT_BORDER_COLOR,
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
                          bottom: Dimensions.PADDING_SIZE_SMALL.h),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.LIGHT_BORDER_COLOR,
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
                width: 250,
                height: 12.h,
              ),
            ],
          )),
    );
  }
}
