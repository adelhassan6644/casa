import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/features/my_appointments/provider/my_appointments_provider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../components/tab_widget.dart';

class MyAppointmentHeader extends StatelessWidget {
  const MyAppointmentHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Text(
            getTranslated("my_appointments", context),
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 18, color: Styles.PRIMARY_COLOR),
          ),
        ),
        Consumer<MyAppointmentsProvider>(builder: (_, provider, child) {
          return Row(
              children: List.generate(
                  provider.tabs.length,
                  (index) => Expanded(
                        child: TabWidget(
                          expand: true,
                          title: getTranslated(provider.tabs[index], context),
                          isSelected: provider.currentTab == index,
                          onTab: () => provider.selectTab(index),
                        ),
                      )));
        })
      ],
    );
  }
}
