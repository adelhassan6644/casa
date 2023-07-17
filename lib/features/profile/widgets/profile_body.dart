import 'package:flutter/material.dart';
import 'package:casa/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Container(
        margin:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorResources.WHITE_COLOR,
            border: Border.all(color: ColorResources.LIGHT_BORDER_COLOR)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated("personal_information", context),
                    style: AppTextStyles.medium.copyWith(
                        color: ColorResources.HEADER,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                CustomButton(
                  text: getTranslated("edit", context),
                  width: 100,
                  height: 35,
                  withBorderColor: false,
                  withShadow: true,
                  iconSize: 15,
                  textColor: ColorResources.SECOUND_PRIMARY_COLOR,
                  svgIcon: SvgImages.edit,
                  backgroundColor: ColorResources.WHITE_COLOR,
                  textSize: 14,
                  onTap: () => provider.updateProfile(),
                  isLoading: provider.isUpdate,
                )
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomTextFormField(
              controller: provider.nameTEC,
              hint: getTranslated("name", context),
              inputType: TextInputType.name,
              valid: Validations.name,
              pSvgIcon: SvgImages.userIcon,
            ),
            CustomTextFormField(
              controller: provider.phoneTEC,
              hint: getTranslated("phone_number", context),
              inputType: TextInputType.phone,
              valid: Validations.phone,
              pSvgIcon: SvgImages.phoneIcon,
            ),
            CustomTextFormField(
              controller: provider.emailTEC,
              hint: getTranslated("mail", context),
              inputType: TextInputType.emailAddress,
              valid: Validations.mail,
              pSvgIcon: SvgImages.mailIcon,
              read: true,
              addBorder: true,
            ),
          ],
        ),
      );
    });
  }
}
