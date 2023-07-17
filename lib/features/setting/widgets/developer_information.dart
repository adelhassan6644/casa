import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/setting_provider.dart';

class DeveloperInformation extends StatelessWidget {
  const DeveloperInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return provider.isLoading
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
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: ColorResources.WHITE_COLOR,
                  border: Border.all(color: ColorResources.LIGHT_BORDER_COLOR)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated("contact_with_us_any_time", context),
                    style: AppTextStyles.medium.copyWith(
                        color: ColorResources.HEADER,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomTextFormField(
                    initialValue: provider.model?.data?.email,
                    hint: getTranslated("mail", context),
                    inputType: TextInputType.emailAddress,
                    pSvgIcon: SvgImages.mailIcon,
                    read: true,
                    addBorder: true,
                  ),
                  CustomTextFormField(
                    initialValue: provider.model?.data?.phone,
                    hint: getTranslated("phone_number", context),
                    inputType: TextInputType.emailAddress,
                    pSvgIcon: SvgImages.phoneIcon,
                    read: true,
                    addBorder: true,
                  ),
                ],
              ),
            );
    });
  }
}
