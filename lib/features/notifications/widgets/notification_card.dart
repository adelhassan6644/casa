import 'package:casa/features/notifications/model/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    this.notification,
    this.withBorder = true,
  }) : super(key: key);
  final NotificationItem? notification;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: BoxDecoration(
          border: withBorder
              ? const Border(
                  bottom: BorderSide(color: Styles.BORDER_COLOR, width: 1))
              : null),
      child: Row(
        children: [
          customImageIconSVG(
            imageName: SvgImages.notifications,
            height: 25,
            width: 25,
            color: Colors.black,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(" ubsufgoue ebwfub kjwbiuf kjbwubf",
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 16, color: Styles.SUBTITLE)),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(DateTime.now().dateFormat(format:"EEE dd/mm"),
                    style: AppTextStyles.regular
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
