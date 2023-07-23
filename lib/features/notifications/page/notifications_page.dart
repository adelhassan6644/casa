import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Styles.SCAFFOLD_BG,
        body: Column(
          children: [
            CustomAppBar(
              title: getTranslated("notifications", context),
            ),
            Expanded(
                child: Container(
                    width: context.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                        vertical: Dimensions.PADDING_SIZE_SMALL.h),
                    decoration: BoxDecoration(
                        color: Styles.WHITE_COLOR,
                        borderRadius: BorderRadius.circular(24)),
                    child: ListAnimator(
                      data: List.generate(10, (index) => NotificationCard(withBorder: index != 9,)),
                    )))
          ],
        ),
      ),
    );
  }
}
