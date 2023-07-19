import 'package:casa/app/core/utils/styles.dart';
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

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
          fit: BoxFit.fitHeight,
        )),
        child: Column(
          children: [
            const CustomAppBar(),
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
                          filter: ui.ImageFilter.blur(
                              sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                Dimensions.PADDING_SIZE_DEFAULT.w,
                                vertical: 30.h),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.06),
                                borderRadius:
                                const BorderRadius.only(topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
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
                                            "forget_password_header",
                                            context),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.semiBold
                                            .copyWith(
                                            fontSize: 28,
                                            color:
                                            Styles.WHITE_COLOR),
                                      ),
                                      Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(
                                                  vertical: 24.h,
                                                ),
                                                child: CustomTextFormField(
                                                  controller:
                                                  provider.mailTEC,
                                                  hint: getTranslated(
                                                      "mail", context),
                                                  inputType: TextInputType
                                                      .emailAddress,
                                                  valid: Validations.mail,
                                                  pSvgIcon:
                                                  SvgImages.mailIcon,
                                                ),
                                              ),
                                              CustomButton(
                                                  text: getTranslated(
                                                      "submit", context),
                                                  onTap: () {
                                                    if (_formKey
                                                        .currentState!
                                                        .validate()) {
                                                      provider
                                                          .forgetPassword();
                                                    }
                                                  },
                                                  isLoading:
                                                  provider.isForget),
                                            ],
                                          )),
                                    ],
                                  );
                                })
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
