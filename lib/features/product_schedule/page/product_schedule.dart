import 'package:casa/features/product_schedule/provider/product_schedule_provider.dart';
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
                    CalenderWidget(
                      id: widget.data["id"],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const ScheduleDateWidget(),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: CustomButton(
                  text: getTranslated("follow_and_payment", context),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
