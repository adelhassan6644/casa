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
import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
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
                          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
                                    getTranslated("signup_header", context),
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.bold.copyWith(
                                        fontSize: 34,
                                        color: Styles.WHITE_COLOR),
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            controller: provider.nameTEC,
                                            hint: getTranslated("name", context),
                                            inputType: TextInputType.name,
                                            valid: Validations.name,
                                            pSvgIcon: SvgImages.userIcon,
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 6.h,horizontal: 12.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  getTranslated("gender", context),
                                                  style: AppTextStyles.medium.copyWith(
                                                          fontSize: 18,
                                                          color: Styles
                                                              .PRIMARY_COLOR),
                                                ),
                                                SizedBox(width: 24.w,),
                                                ...List.generate(2, (index) => Expanded(
                                                  child: CustomRadioButton(
                                                    check: provider.userType==index,
                                                    title: getTranslated(provider.usersTypes[index], context),
                                                    onChange: (v){
                                                      if(v){
                                                        provider.selectedUserType(index);
                                                      }
                                                    },
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                          CustomTextFormField(
                                            controller: provider.mailTEC,
                                            hint:
                                                getTranslated("mail", context),
                                            inputType:
                                                TextInputType.emailAddress,
                                            valid: Validations.mail,
                                            pSvgIcon: SvgImages.mailIcon,
                                          ),
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
                                            valid: Validations.firstPassword,
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
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    provider.register();
                                                  }
                                                },
                                                isLoading: provider.isRegister),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${getTranslated("have_acc", context)} ",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.regular
                                                    .copyWith(
                                                        color: Styles
                                                            .PRIMARY_COLOR,
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  CustomNavigator.push(
                                                      Routes.LOGIN,
                                                      clean: true);
                                                  provider.clear();
                                                },
                                                child: Text(
                                                  getTranslated(
                                                      "login", context),
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyles.bold
                                                      .copyWith(
                                                    color: Styles.WHITE_COLOR,
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
