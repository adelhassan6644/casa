import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:casa/components/empty_widget.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
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
            Expanded(child:
                Consumer<NotificationsProvider>(builder: (_, provider, child) {
              return Container(
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
                  child: provider.isLoading
                      ? ListAnimator(
                          data: List.generate(
                              10,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.PADDING_SIZE_SMALL),
                                    child: CustomShimmerContainer(
                                      width: context.width,
                                      height: 60,
                                      radius: 12,
                                    ),
                                  )))
                      : provider.model != null &&
                              provider.model?.data != null &&
                              provider.model!.data!.isNotEmpty
                          ? RefreshIndicator(
                              color: Styles.PRIMARY_COLOR,
                              onRefresh: () async {
                                sl<NotificationsProvider>().getNotifications();
                              },
                              child: Column(
                                children: [
                                  ListAnimator(
                                      data: List.generate(
                                          provider.model?.data?.length ?? 0,
                                          (index) => Dismissible(
                                                background: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      width: 100.w,
                                                      height: 30.h,
                                                      text: getTranslated(
                                                          "delete", context),
                                                      svgIcon: SvgImages.cancel,
                                                      iconSize: 12,
                                                      iconColor:
                                                          Styles.IN_ACTIVE,
                                                      textColor:
                                                          Styles.IN_ACTIVE,
                                                      backgroundColor: Styles
                                                          .IN_ACTIVE
                                                          .withOpacity(0.12),
                                                    ),
                                                  ],
                                                ),
                                                key: ValueKey(index),
                                                confirmDismiss:
                                                    (DismissDirection
                                                        direction) async {
                                                  provider.deleteNotification(
                                                      provider
                                                              .model
                                                              ?.data?[index]
                                                              .id ??
                                                          0);
                                                  return false;
                                                },
                                                child: NotificationCard(
                                                  withBorder: index != 9,
                                                  notification: provider
                                                      .model?.data?[index],
                                                ),
                                              ))),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              color: Styles.PRIMARY_COLOR,
                              onRefresh: () async {
                                sl<NotificationsProvider>().getNotifications();
                              },
                              child:  Column(
                                children: [
                                  Expanded(
                                    child: ListAnimator(data: [
                                      EmptyState(
                                        txt: getTranslated("no_notifications", context),
                                        spaceBtw: 50,
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ));
            }))
          ],
        ),
      ),
    );
  }
}
