import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:casa/components/custom_images.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            Images.signUpImage,
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Column(
          children: [
            customImageIcon(imageName: Images.logo, height: 140, width: 160),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
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
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Consumer<AuthProvider>(
                                      builder: (_, provider, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          getTranslated(
                                              "signup_header", context),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                                  fontSize: 28,
                                                  color: ColorResources.HEADER),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 24.h),
                                          child: Text(
                                            getTranslated(
                                                "signup_description", context),
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: ColorResources
                                                        .HINT_COLOR),
                                          ),
                                        ),
                                        Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                CustomTextFormField(
                                                  controller: provider.nameTEC,
                                                  hint: getTranslated(
                                                      "name", context),
                                                  inputType: TextInputType.name,
                                                  valid: Validations.name,
                                                  pSvgIcon: SvgImages.userIcon,
                                                ),
                                                CustomTextFormField(
                                                  controller: provider.phoneTEC,
                                                  hint: getTranslated(
                                                      "phone_number", context),
                                                  inputType:
                                                      TextInputType.phone,
                                                  valid: Validations.phone,
                                                  pSvgIcon: SvgImages.phoneIcon,
                                                ),
                                                CustomTextFormField(
                                                  controller: provider.mailTEC,
                                                  hint: getTranslated(
                                                      "mail", context),
                                                  inputType: TextInputType
                                                      .emailAddress,
                                                  valid: Validations.mail,
                                                  pSvgIcon: SvgImages.mailIcon,
                                                ),
                                                CustomTextFormField(
                                                  keyboardAction:
                                                      TextInputAction.done,
                                                  controller:
                                                      provider.passwordTEC,
                                                  hint: getTranslated(
                                                      "password", context),
                                                  inputType: TextInputType
                                                      .visiblePassword,
                                                  valid:
                                                      Validations.firstPassword,
                                                  pSvgIcon: SvgImages.lockIcon,
                                                  isPassword: true,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 24.h,
                                                  ),
                                                  child: CustomButton(
                                                      text: getTranslated(
                                                          "signup", context),
                                                      onTap: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          provider.register();
                                                        }
                                                      },
                                                      isLoading:
                                                          provider.isRegister),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        getTranslated(
                                                            "have_acc",
                                                            context),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: AppTextStyles
                                                            .medium
                                                            .copyWith(
                                                                color:
                                                                    ColorResources
                                                                        .TITLE,
                                                                fontSize: 16,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          CustomNavigator.push(
                                                              Routes.LOGIN,
                                                              clean: true);
                                                          provider.clear();
                                                        },
                                                        child: Text(
                                                          getTranslated(
                                                              "login_now",
                                                              context),
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                            color:
                                                                ColorResources
                                                                    .HEADER,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 16,
                                                            decorationColor:
                                                                ColorResources
                                                                    .HEADER,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    CustomNavigator.push(
                                                        Routes.MAIN_PAGE);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 12.h),
                                                    child: Text(
                                                      getTranslated(
                                                          "login_as_a_guest",
                                                          context),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyles
                                                          .semiBold
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: ColorResources
                                                                  .HINT_COLOR),
                                                    ),
                                                  ),
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
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                    ],
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
