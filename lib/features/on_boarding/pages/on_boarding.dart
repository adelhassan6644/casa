import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'dart:ui' as ui;
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

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
            Images.onBoarding,
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Column(
          children: [
            SizedBox(
              height: context.toPadding,
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 75.h),
                            child: ClipRRect(
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
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ///header
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.h),
                                        child: Text(
                                          getTranslated(
                                              "on_boarding_header", context),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                                  fontSize: 28,
                                                  color: ColorResources
                                                      .WHITE_COLOR),
                                        ),
                                      ),

                                      ///description
                                      Text(
                                        getTranslated(
                                            "on_boarding_description", context),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 16,
                                            color: ColorResources.WHITE_COLOR),
                                      ),

                                      ///to login
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 24.h,
                                        ),
                                        child: CustomButton(
                                          text: getTranslated("login", context),
                                          onTap: () {
                                            CustomNavigator.push(Routes.LOGIN,
                                                clean: true);
                                          },
                                        ),
                                      ),

                                      ///to register
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            getTranslated(
                                                "do_not_have_acc", context),
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    color: ColorResources
                                                        .SECOUND_PRIMARY_COLOR,
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              CustomNavigator.push(
                                                  Routes.REGISTER,
                                                  clean: true);
                                            },
                                            child: Text(
                                              getTranslated(
                                                  "signup_now", context),
                                              style:
                                                  AppTextStyles.medium.copyWith(
                                                color:
                                                    ColorResources.WHITE_COLOR,
                                                fontSize: 16,
                                                decorationColor:
                                                    ColorResources.WHITE_COLOR,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          customImageIcon(
                              imageName: Images.logo, height: 140, width: 160),
                        ],
                      ),
                      SizedBox(
                        height: context.toPadding,
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
