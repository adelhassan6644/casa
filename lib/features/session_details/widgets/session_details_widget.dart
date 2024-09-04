import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/features/session_details/widgets/payment_status.dart';
import 'package:casa/main_models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../reservations/model/reservation_model.dart';

class SessionDetailsWidget extends StatelessWidget {
  final ReservationModel model;
  const SessionDetailsWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage.containerNewWorkImage(
                image: model.image ?? "",
                width: context.width,
                fit: BoxFit.fitWidth,
                height: 250.h,
                radius: 30),

            ///Details
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Session Name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          " ${model.service}",
                          style: AppTextStyles.bold.copyWith(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: Styles.PRIMARY_COLOR),
                          maxLines: 1,
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      model.subService ?? "",
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.PRIMARY_COLOR),
                      maxLines: 1,
                    ),
                  ),

                  ///Location
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(getTranslated("address", context),
                        style: AppTextStyles.semiBold.copyWith(
                            height: 1, fontSize: 18, color: Styles.TITLE)),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            model.address ?? "sdfw",
                            style: AppTextStyles.medium
                                .copyWith(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Date
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(getTranslated("date", context),
                        style: AppTextStyles.semiBold.copyWith(
                            height: 1, fontSize: 18, color: Styles.TITLE)),
                  ),
               Row(
                    children: [
                      Text(getTranslated("day", context),
                          style: AppTextStyles.regular.copyWith(
                              height: 1,
                              fontSize: 14,
                              color: Styles.DETAILS_COLOR)),
                      Expanded(
                        child: Text(
                            model.startTime!.dateFormat(format: "EEEE dd/MM"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium.copyWith(
                                height: 1, fontSize: 16, color: Colors.black)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                 Row(
                    children: [
                      Text(getTranslated("time", context),
                          style: AppTextStyles.regular.copyWith(
                              height: 1,
                              fontSize: 14,
                              color: Styles.DETAILS_COLOR)),
                      Expanded(
                        child: Text(
                            model.startTime!.dateFormat(format: "hh:mm aa"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium.copyWith(
                                height: 1, fontSize: 16, color: Colors.black)),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
