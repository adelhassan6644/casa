import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/count_down.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_pin_code_field.dart';
import '../provider/auth_provider.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.fromRegister}) : super(key: key);
  final bool fromRegister;
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
            const CustomAppBar(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 24.h,
                                    ),
                                    child: Text(
                                      getTranslated("verify_header", context),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bold.copyWith(
                                          fontSize: 22,
                                          color: Styles.WHITE_COLOR),
                                    ),
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 12.h,
                                            ),
                                            child: Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: CustomPinCodeField(
                                                    validation:
                                                        Validations.code,
                                                    controller:
                                                        provider.codeTEC,
                                                    onChanged: (v) {})),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CountDown(
                                                onCount: () => provider.resend(
                                                    widget.fromRegister),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 24.h,
                                            ),
                                            child: CustomButton(
                                                text: getTranslated(
                                                    "confirm", context),
                                                onTap: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    provider.verify(
                                                        widget.fromRegister);
                                                  }
                                                },
                                                isLoading: provider.isVerify),
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
