import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';

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
            Images.authImage,
          ),
          fit: BoxFit.fitHeight,
        )),
        child: Column(
          children: [
            SizedBox(
              height: context.toPadding,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///header
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Text(
                          getTranslated("on_boarding_header", context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 34, color: Styles.WHITE_COLOR),
                        ),
                      ),

                      ///description
                      Text(
                        getTranslated("on_boarding_description", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular
                            .copyWith(fontSize: 26, color: Styles.WHITE_COLOR),
                      ),

                      ///to signup
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 24.h,
                        ),
                        child: CustomButton(
                          text: getTranslated("signup", context),
                          textColor: Styles.PRIMARY_COLOR,
                          backgroundColor: Styles.WHITE_COLOR,
                          onTap: () {
                            CustomNavigator.push(Routes.REGISTER, clean: true);
                          },
                         withShadow: true,
                        ),
                      ),

                      ///to login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated("have_acc", context),
                            style: AppTextStyles.medium.copyWith(
                                color: Styles.WHITE_COLOR,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                          InkWell(
                            onTap: () {
                              CustomNavigator.push(Routes.LOGIN,
                                  clean: true);
                            },
                            child: Text(
                              getTranslated("login", context),
                              style: AppTextStyles.medium.copyWith(
                                color: Styles.PRIMARY_COLOR,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),
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
