import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            Images.authImage,
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                const CustomAppBar(),
                customImageIcon(
                    imageName: Images.logo, height: 140, width: 160),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.h),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(25),
                                  child: BackdropFilter(
                                    filter: ui.ImageFilter.blur(
                                        sigmaX: 0.0, sigmaY: 0.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_DEFAULT.w,
                                          vertical: 30.h),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Consumer<AuthProvider>(
                                          builder: (_, provider, child) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 24.h),
                                              child: Text(
                                                getTranslated(
                                                    "reset_password_header",
                                                    context),
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.semiBold
                                                    .copyWith(
                                                        fontSize: 22,
                                                        color: Styles
                                                            .HEADER),
                                              ),
                                            ),
                                            Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: [
                                                    CustomTextFormField(
                                                      keyboardAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          provider.passwordTEC,
                                                      hint: getTranslated(
                                                          "password", context),
                                                      inputType: TextInputType
                                                          .visiblePassword,
                                                      valid: Validations
                                                          .firstPassword,
                                                      pSvgIcon:
                                                          SvgImages.lockIcon,
                                                      isPassword: true,
                                                    ),
                                                    CustomTextFormField(
                                                      keyboardAction:
                                                          TextInputAction.done,
                                                      controller: provider
                                                          .confirmPasswordTEC,
                                                      hint: getTranslated(
                                                          "confirm_password",
                                                          context),
                                                      inputType: TextInputType
                                                          .visiblePassword,
                                                      valid: (v) => Validations
                                                          .confirmPassword(
                                                              provider
                                                                  .passwordTEC
                                                                  .text
                                                                  .trim(),
                                                              v?.trim()),
                                                      pSvgIcon:
                                                          SvgImages.lockIcon,
                                                      isPassword: true,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 24.h,
                                                      ),
                                                      child: CustomButton(
                                                          text: getTranslated(
                                                              "confirm",
                                                              context),
                                                          onTap: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              provider
                                                                  .resetPassword();
                                                            }
                                                          },
                                                          isLoading:
                                                              provider.isReset),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                              // customImageIcon(
                              //     imageName: Images.logo, height: 140, width: 160),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_DEFAULT.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
