import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/setting_provider.dart';

class DeveloperDescription extends StatelessWidget {
  const DeveloperDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return (provider.isLoading)
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: CustomShimmerContainer(
                width: context.width,
                height: 270,
                radius: 18,
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Styles.WHITE_COLOR,
                  border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        getTranslated("about_us", context).replaceAll("ا", " "),
                        style: AppTextStyles.medium.copyWith(
                            color: Styles.HEADER,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        provider.model?.data?.name ?? "",
                        style: AppTextStyles.medium.copyWith(
                            color: const Color(0xFFF8A14E),
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    provider.model?.data?.aboutUs ?? "",
                    style: AppTextStyles.light.copyWith(
                        color: Styles.DETAILS_COLOR,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 10,
                  ),
                ],
              ),
            );
    });
  }
}
