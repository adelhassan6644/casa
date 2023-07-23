import 'package:flutter/material.dart';
import 'package:casa/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_text_form_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                getTranslated("personal_information", context),
                style: AppTextStyles.medium.copyWith(
                    color: Styles.DETAILS_COLOR,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Styles.WHITE_COLOR,
                  border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
              child: Column(
                children: [
                  ///Name
                  CustomTextFormField(
                    controller: provider.nameTEC,
                    hint: getTranslated("name", context),
                    inputType: TextInputType.name,
                    valid: Validations.name,
                    pSvgIcon: SvgImages.userIcon,
                  ),

                  ///Gender
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                    child: Row(
                      children: [
                        Text(
                          getTranslated("gender", context),
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18, color: Styles.PRIMARY_COLOR),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        ...List.generate(
                            2,
                            (index) => Expanded(
                                  child: CustomRadioButton(
                                    selectedColor: Styles.PRIMARY_COLOR,
                                    check: provider.userType == index,
                                    title: getTranslated(
                                        provider.usersTypes[index], context),
                                    onChange: (v) {
                                      if (v) {
                                        provider.selectedUserType(index);
                                      }
                                    },
                                  ),
                                ))
                      ],
                    ),
                  ),

                  ///Phone
                  CustomTextFormField(
                    controller: provider.phoneTEC,
                    hint: getTranslated("phone_number", context),
                    inputType: TextInputType.phone,
                    valid: Validations.phone,
                    pSvgIcon: SvgImages.phoneIcon,
                  ),

                  ///Mail
                  CustomTextFormField(
                    controller: provider.emailTEC,
                    hint: getTranslated("mail", context),
                    inputType: TextInputType.emailAddress,
                    valid: Validations.mail,
                    pSvgIcon: SvgImages.mailIcon,
                    read: true,
                    addBorder: true,
                  ),

                  ///To save Changes
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomButton(
                    text: getTranslated("save_changes", context),
                    onTap: () => provider.updateProfile(),
                    isLoading: provider.isUpdate,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
