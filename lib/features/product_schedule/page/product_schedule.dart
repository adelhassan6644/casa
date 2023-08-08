import 'package:casa/features/product_schedule/provider/product_schedule_provider.dart';
import 'package:casa/features/product_schedule/repo/product_schedule_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../widgets/calender_widget.dart';
import '../widgets/schedule_date_widget.dart';

class ProductSchedule extends StatelessWidget {
  const ProductSchedule({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductScheduleProvider(repo: sl<ProductScheduleRepo>())
        ..getProductSchedule(data["id"]),
      child: Consumer<ProductScheduleProvider>(builder: (_, provider, child) {
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
                    child: ListAnimator(
                      data: [
                        CalenderWidget(
                          id: data["id"],
                        ),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_DEFAULT.h,
                        ),
                        const ScheduleDateWidget(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: CustomButton(
                    text: getTranslated("follow_and_payment", context),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
