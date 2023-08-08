import 'package:casa/features/notifications/model/notifications_model.dart';
import 'package:casa/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';

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
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => sl<NotificationsProvider>().readNotification(
          notification?.id ?? 0,
          isReservation: notification?.reservationId != null),
      child: Container(
        width: context.width,
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
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
                    child: Text(notification?.title ?? "",
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium
                            .copyWith(fontSize: 16, color: Styles.SUBTITLE)),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                      notification?.createdAt
                              ?.dateFormat(format: "EEE dd/mm") ??
                          "",
                      style: AppTextStyles.regular
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
