import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  final bool fromMain;
  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(
                Images.authImage,
              ),
              fit: BoxFit.fitHeight,
            )),
        child: Column(
          children: [
            Visibility(visible: widget.fromMain, child: const CustomAppBar()),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter:
                              ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                vertical: 30.h),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: Consumer<AuthProvider>(
                                builder: (_, provider, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated("login_header", context),
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 28,
                                        color: Styles.WHITE_COLOR),
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          // CustomTextFormField(
                                          //   controller:
                                          //   provider.mailTEC,
                                          //   hint: getTranslated(
                                          //       "mail", context),
                                          //   inputType: TextInputType
                                          //       .emailAddress,
                                          //   valid: Validations.mail,
                                          //   pSvgIcon:
                                          //   SvgImages.mailIcon,
                                          // ),

                                          CustomTextFormField(
                                            controller: provider.phoneTEC,
                                            hint: getTranslated(
                                                "phone_number", context),
                                            inputType: TextInputType.phone,
                                            valid: Validations.phone,
                                            pSvgIcon: SvgImages.phoneIcon,
                                          ),
                                          CustomTextFormField(
                                            keyboardAction:
                                                TextInputAction.done,
                                            controller: provider.passwordTEC,
                                            hint: getTranslated(
                                                "password", context),
                                            inputType:
                                                TextInputType.visiblePassword,
                                            valid: Validations.password,
                                            pSvgIcon: SvgImages.lockIcon,
                                            isPassword: true,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  CustomNavigator.push(
                                                      Routes.FORGET_PASSWORD);
                                                  provider.clear();
                                                },
                                                child: Text(
                                                  getTranslated(
                                                      "forget_password",
                                                      context),
                                                  style: AppTextStyles.medium
                                                      .copyWith(
                                                    color: Styles.WHITE_COLOR,
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Styles.WHITE_COLOR,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 24.h,
                                            ),
                                            child: CustomButton(
                                                text: getTranslated(
                                                    "login", context),
                                                onTap: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    provider.logIn();
                                                  }
                                                },
                                                isLoading: provider.isLoading),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                getTranslated(
                                                    "do_not_have_acc", context),
                                                textAlign: TextAlign.end,
                                                style: AppTextStyles.regular
                                                    .copyWith(
                                                        color:
                                                            Styles.WHITE_COLOR,
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  CustomNavigator.push(
                                                      Routes.REGISTER,
                                                      clean: true);
                                                  provider.clear();
                                                },
                                                child: Text(
                                                  " ${getTranslated("signup", context)}",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles.bold
                                                      .copyWith(
                                                    color: Styles.PRIMARY_COLOR,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT.h,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
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
