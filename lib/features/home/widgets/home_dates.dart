import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_images.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/main_page/provider/main_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/provider/localization_provider.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../reservations/provider/reservations_provider.dart';
import '../../reservations/widgets/cancellation_dialog.dart';

class HomeDates extends StatelessWidget {
  const HomeDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationsProvider>(builder: (_, provider, child) {
      return provider.isGetting
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_SMALL.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomShimmerContainer(
                    width: 200,
                    height: 16,
                    radius: 5,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomShimmerContainer(
                    width: context.width,
                    height: 100,
                    radius: 15,
                  ),
                ],
              ),
            )
          : provider.nextReservations != null &&
                  provider.nextReservations!.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated("your_upcoming_dates", context),
                              style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 22,
                                  color: Styles.PRIMARY_COLOR,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Consumer<MainPageProvider>(
                              builder: (_, mainProvider, child) {
                            return Transform.scale(
                              scaleX:Provider.of<LocalizationProvider>(context,listen: false).locale.languageCode=="en"?-1: 1,
                              child: customImageIconSVG(
                                  imageName: SvgImages.arrowLeft,
                                  color: Styles.PRIMARY_COLOR,
                                  onTap: () =>
                                      mainProvider.updateDashboardIndex(1)),
                            );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: context.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Styles.WHITE_COLOR,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomNetworkImage.containerNewWorkImage(
                              image: provider.nextReservations?[0].image ?? "",
                              height: 95.h,
                              width: 100.w,
                              fit: BoxFit.cover,
                              radius: 12.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            provider.nextReservations?[0]
                                                    .subService ??
                                                "",
                                            style: AppTextStyles.semiBold
                                                .copyWith(
                                                    fontSize: 16,
                                                    color:
                                                        Styles.PRIMARY_COLOR)),
                                      ),
                                      CustomButton(
                                        width: 95.w,
                                        height: 30.h,
                                        text: getTranslated("cancel", context),
                                        svgIcon: SvgImages.cancel,
                                        iconSize: 12,
                                        iconColor: Styles.IN_ACTIVE,
                                        textColor: Styles.IN_ACTIVE,
                                        backgroundColor:
                                            Styles.IN_ACTIVE.withOpacity(0.12),
                                        onTap: () => CustomSimpleDialog
                                            .parentSimpleDialog(
                                                customListWidget: [
                                              CancellationDialog(
                                                  id: provider
                                                      .nextReservations?[0].id)
                                            ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(getTranslated("time", context)+'  ',
                                          style: AppTextStyles.regular.copyWith(
                                              height: 1,
                                              fontSize: 12,
                                              color: Styles.DETAILS_COLOR)),
                                      Expanded(
                                        child: Text(
                                            provider.nextReservations![0].date!
                                                .dateFormat(
                                                    format: "EEEE dd/MM"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    height: 1,
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(getTranslated("time", context)+'  ',
                                          style: AppTextStyles.regular.copyWith(
                                              height: 1,
                                              fontSize: 12,
                                              color: Styles.DETAILS_COLOR)),
                                      Expanded(
                                        child: Text(
                                            provider.nextReservations![0].date!
                                                .dateFormat(format: "hh:mm aa"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    height: 1,
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      customImageIconSVG(
                                          imageName: SvgImages.location,
                                          height: 20,
                                          width: 20,
                                          color: Styles.DETAILS_COLOR),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          provider.nextReservations?[0]
                                                  .address ??
                                              "",
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                          "${provider.nextReservations?[0].price ?? 0}"+ getTranslated("sar", context),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 14,
                                              color: Styles.PRIMARY_COLOR)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox();
    });
  }
}
