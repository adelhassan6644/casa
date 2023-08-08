import 'package:casa/features/ratting/provider/ratting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/back_icon.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../reservations/model/reservation_model.dart';

class RattingView extends StatelessWidget {
  const RattingView({Key? key, required this.reservation}) : super(key: key);
  final ReservationModel reservation;

  @override
  Widget build(BuildContext context) {
    return Consumer<RattingProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          Text(
            getTranslated("tell_us_your_opinion", context),
            style: AppTextStyles.semiBold
                .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 18),
          ),

          ///Rate Count
          Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GestureDetector(
                    onTap: () => provider.selectedRate(index),
                    child: customImageIconSVG(
                      height: 35,
                      width: 35,
                      color: provider.ratting! < index
                          ? Styles.DETAILS_COLOR
                          : Colors.yellow,
                      imageName: provider.ratting! < index
                          ? SvgImages.emptyStar
                          : SvgImages.fillStar,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///Rate Description
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: "قم بتقييم تجربة جلسة ",
                      style: AppTextStyles.regular
                          .copyWith(color: Styles.DETAILS_COLOR, fontSize: 16),
                      children: [
                        TextSpan(
                          text: reservation.subService ?? "",
                          style: AppTextStyles.medium.copyWith(
                              color: Styles.PRIMARY_COLOR, fontSize: 16),
                        )
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "التي قدمة إليك الأخصائي ",
                      style: AppTextStyles.regular
                          .copyWith(color: Styles.DETAILS_COLOR, fontSize: 16),
                      children: [
                        TextSpan(
                          text: reservation.subService ?? "",
                          style: AppTextStyles.medium.copyWith(
                              color: Styles.PRIMARY_COLOR, fontSize: 16),
                        )
                      ]),
                ),
              ],
            ),
          ),

          ///Send Rate
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
            child: CustomButton(
              text: getTranslated("send_my_rate", context),
              onTap: () => provider.sendFeedback(reservation),
              isLoading: provider.isLoading,
            ),
          ),
          CustomButton(
            text: getTranslated("rate_late", context),
            fIconWidget: const FilteredBackIcon(),
            iconSize: 12,
            iconColor: Styles.PRIMARY_COLOR,
            textColor: Styles.PRIMARY_COLOR,
            backgroundColor: Styles.SCAFFOLD_BG,
            onTap: () => CustomNavigator.pop(),
          ),
        ],
      );
    });
  }
}
