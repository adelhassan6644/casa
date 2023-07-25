import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_network_image.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({Key? key, this.isNext = true}) : super(key: key);
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Styles.WHITE_COLOR,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: "",
              height: 95.h,
              width: 100.w,
              fit: BoxFit.cover,
              radius: 12.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("مساج",
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 16,
                                      color: Styles.PRIMARY_COLOR)),
                            ),
                            CustomButton(
                              width: 100.w,
                              height: 30.h,
                              text: getTranslated(
                                  isNext ? "edit" : "again", context),
                              svgIcon: SvgImages.arrowLeft,
                              iconSize: 16,
                              iconColor: Styles.WHITE_COLOR,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text("اليوم  ",
                                style: AppTextStyles.regular.copyWith(
                                    height: 1,
                                    fontSize: 12,
                                    color: Styles.DETAILS_COLOR)),
                            Expanded(
                              child: Text(
                                  DateTime.now()
                                      .dateFormat(format: "EEEE dd,MM"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium.copyWith(
                                      height: 1,
                                      fontSize: 14,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Text("الساعة  ",
                                style: AppTextStyles.regular.copyWith(
                                    height: 1,
                                    fontSize: 12,
                                    color: Styles.DETAILS_COLOR)),
                            Expanded(
                              child: Text(
                                  DateTime.now().dateFormat(format: "hh:mm aa"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium.copyWith(
                                      height: 1,
                                      fontSize: 14,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Expanded(
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
                                      "حي العزيزية",
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("${100} ريال",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14, color: Styles.PRIMARY_COLOR)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
