import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/features/notifications/model/notifications_model.dart';
import 'package:casa/features/notifications/provider/notifications_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.notification,
    this.withBorder = true,
  }) : super(key: key);
  final NotificationItem? notification;
  final bool withBorder;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (widget.notification?.isRead != true) {
          sl<NotificationsProvider>()
              .readNotification(widget.notification?.id ?? 0);
          setState(() => widget.notification?.isRead = true);
        }
      },
      child: Container(
        width: context.width,
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
        decoration: BoxDecoration(
            border: widget.withBorder
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
                    child: Wrap(
                      children: [
                        Text(widget.notification?.notificationBody?.title ?? "",
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium
                                .copyWith(fontSize: 16, color: widget.notification?.isRead == true
                                ? Styles.DETAILS_COLOR
                                : Styles.SUBTITLE)),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            CustomNavigator.push(Routes.DASHBOARD,clean: true,arguments: 0);
                          },
                          child: Text(
                            " ${getTranslated(widget.notification?.notificationBody?.reservationId != null ? "details" : "know_more_bout_it", context)}",
                            style: AppTextStyles.regular.copyWith(
                                color: Colors.blueAccent, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                      widget.notification?.createdAt
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
