import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/payment/model/payment_body_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';

class SessionSummary extends StatelessWidget {
  const SessionSummary({Key? key, required this.model}) : super(key: key);
  final PaymentBodyModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL),
            child: Text(getTranslated("session_summery", context),
                style: AppTextStyles.semiBold.copyWith(fontSize: 16)),
          ),
          Container(
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
                  image: model.itemData?.image ?? "",
                  height: 95.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                  radius: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.itemData?.subService ?? "",
                          maxLines: 1,
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              color: Styles.PRIMARY_COLOR)),
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
                                model.scheduleModel!.startTime!
                                    .dateFormat(format: "EEEE dd/MM"),
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
                                model.scheduleModel!.startTime!
                                    .dateFormat(format: "hh:mm aa"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium.copyWith(
                                    height: 1,
                                    fontSize: 14,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
