import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/product_schedule/provider/product_schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../widgets/schedule_date_widget.dart';

class ProductSchedule extends StatelessWidget {
  const ProductSchedule({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.SCAFFOLD_BG,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "حجز جلسة ${data["title"]}",
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: ListAnimator(data: [
                    !provider.isLoading
                        ? Visibility(
                            visible: provider.dayScheduleModel != null &&
                                provider.dayScheduleModel != [],
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.h,
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_DEFAULT.h,
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
                                          provider.day?.dateFormat(
                                                  format: "EEEE dd/mm") ??
                                              "",
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 18,
                                              color: Styles.PRIMARY_COLOR)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h),
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
                                          "مدة الجلسة ${provider.dayScheduleModel?[0].duration ?? ""}",
                                          style: AppTextStyles.regular.copyWith(
                                              fontSize: 14,
                                              color: Styles.DETAILS_COLOR)),
                                    ],
                                  )),
                            ),
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
