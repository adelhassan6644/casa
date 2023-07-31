import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/empty_widget.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/reservations/widgets/cancellation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../provider/reservations_provider.dart';
import 'reservation_card.dart';

class NextAppointments extends StatefulWidget {
  const NextAppointments({Key? key}) : super(key: key);

  @override
  State<NextAppointments> createState() => _NextAppointmentsState();
}

class _NextAppointmentsState extends State<NextAppointments> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<ReservationsProvider>().nextScroll(controller);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationsProvider>(builder: (_, provider, child) {
      return provider.isGetting
          ? Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: ListAnimator(
                  controller: controller,
                  data: List.generate(
                    10,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: Dimensions.PADDING_SIZE_SMALL.h),
                      child: CustomShimmerContainer(
                        height: 100,
                        width: context.width,
                        radius: 15,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : provider.nextReservations != null &&
                  provider.nextReservations!.isNotEmpty
              ? RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    sl<ReservationsProvider>().getNextReservations();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: ListAnimator(
                            controller: controller,
                            data: List.generate(
                              provider.nextReservations?.length ?? 0,
                              (index) => Dismissible(
                                background: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      width: 85.w,
                                      height: 30.h,
                                      text: getTranslated("cancel", context),
                                      svgIcon: SvgImages.cancel,
                                      iconSize: 12,
                                      iconColor: Styles.IN_ACTIVE,
                                      textColor: Styles.IN_ACTIVE,
                                      backgroundColor:
                                          Styles.IN_ACTIVE.withOpacity(0.12),
                                    ),
                                  ],
                                ),
                                key: ValueKey(index),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  CustomSimpleDialog.parentSimpleDialog(
                                    customListWidget: [
                                      const CancellationDialog()
                                    ],
                                  );
                                  return false;
                                },
                                child: AppointmentCard(
                                  reservation:
                                      provider.nextReservations![index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    sl<ReservationsProvider>().getNextReservations();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: ListAnimator(
                            data: [
                              EmptyState(
                                img: Images.emptyReservations,
                                imgHeight: 215.h,
                                imgWidth: 215.w,
                                isSvg: false,
                                txt: getTranslated(
                                    "empty_next_reservations_title", context),
                                subText: getTranslated(
                                    "empty_next_reservations_description",
                                    context),
                                btnText:
                                    getTranslated("continue_browsing", context),
                                onTap: () => sl<MainPageProvider>()
                                    .updateDashboardIndex(0),
                                originalButton: false,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
    });
  }
}
