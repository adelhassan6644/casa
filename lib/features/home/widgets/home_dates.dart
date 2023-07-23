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

class HomeDates extends StatelessWidget {
  const HomeDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              customImageIconSVG(
                  imageName: SvgImages.arrowLeft,
                  color: Styles.PRIMARY_COLOR,
                  onTap: () {})
            ],
          ),
          SizedBox(height: 16.h,),
          Container(
            width: context.width,
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("مساج",
                                style: AppTextStyles.semiBold.copyWith(
                                    fontSize: 16, color: Styles.PRIMARY_COLOR)),
                          ),
                          CustomButton(
                            width: 85.w,
                            height: 30.h,
                            text: "إلغاء",
                            svgIcon: SvgImages.cancel,
                            iconSize: 12,
                            iconColor:  Styles.PRIMARY_COLOR,
                            textColor: Styles.PRIMARY_COLOR,
                            backgroundColor: Styles.BORDER_COLOR,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Text( "اليوم  ",
                              style: AppTextStyles.regular.copyWith(
                                  height: 1,
                                  fontSize: 12, color: Styles.DETAILS_COLOR)),
                          Expanded(
                            child: Text(DateTime.now().dateFormat(format:"EEEE dd,MM"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium.copyWith(
                                    height: 1,
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Text( "الساعة  ",
                              style: AppTextStyles.regular.copyWith(
                                  height: 1,
                                  fontSize: 12, color: Styles.DETAILS_COLOR)),
                          Expanded(
                            child: Text(DateTime.now().dateFormat(format:"hh:mm aa"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium.copyWith(
                                    height: 1,
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
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
                              style: AppTextStyles.medium
                                  .copyWith(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Text("${100} ريال",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14, color: Styles.PRIMARY_COLOR)),
                        ],
                      ),
                    ],),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
