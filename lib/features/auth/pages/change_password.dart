import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 160 + context.toPadding,
                  width: context.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.profileBGImage),
                          fit: BoxFit.fitHeight)),
                  child: const SizedBox(),
                ),
                const CustomAppBar()
              ],
            ),
            Expanded(
                child: ListAnimator(
              data: [
                SizedBox(
                  height: 70.h,
                ),
                Consumer<AuthProvider>(builder: (_, provider, child) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: ColorResources.WHITE_COLOR,
                        border: Border.all(
                            color: ColorResources.LIGHT_BORDER_COLOR)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                          child: Text(
                            getTranslated("change_password_header", context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.semiBold.copyWith(
                                fontSize: 22,
                                color: ColorResources.PRIMARY_COLOR),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  keyboardAction: TextInputAction.next,
                                  controller: provider.currentPasswordTEC,
                                  hint: getTranslated(
                                      "current_password", context),
                                  inputType: TextInputType.visiblePassword,
                                  valid: Validations.password,
                                  pSvgIcon: SvgImages.lockIcon,
                                  isPassword: true,
                                ),
                                CustomTextFormField(
                                  keyboardAction: TextInputAction.next,
                                  controller: provider.passwordTEC,
                                  hint: getTranslated("new_password", context),
                                  inputType: TextInputType.visiblePassword,
                                  valid: (v) => Validations.newPassword(
                                      provider.currentPasswordTEC.text.trim(),
                                      v?.trim()),
                                  pSvgIcon: SvgImages.lockIcon,
                                  isPassword: true,
                                ),
                                CustomTextFormField(
                                  keyboardAction: TextInputAction.done,
                                  controller: provider.confirmPasswordTEC,
                                  hint: getTranslated(
                                      "confirm_new_password", context),
                                  inputType: TextInputType.visiblePassword,
                                  valid: (v) => Validations.confirmNewPassword(
                                      provider.passwordTEC.text.trim(),
                                      v?.trim()),
                                  pSvgIcon: SvgImages.lockIcon,
                                  isPassword: true,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.h,
                                  ),
                                  child: CustomButton(
                                      text: getTranslated("confirm", context),
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          provider.changePassword();
                                        }
                                      },
                                      isLoading: provider.isChange),
                                ),
                              ],
                            )),
                      ],
                    ),
                  );
                }),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
