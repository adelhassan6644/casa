import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/config_provider.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.SCAFFOLD_BG,
      body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: getTranslated("contact_with_us", context)),
              Consumer<ConfigProvider>(builder: (_, provider, child) {
                return !provider.isLoading
                    ? Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_SMALL.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_SMALL.h,
                        ),
                        decoration: BoxDecoration(
                            color: Styles.WHITE_COLOR,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            ListAnimator(
                              data: [
                                Center(
                                  child: customImageIcon(
                                      imageName: Images.contactPhone,
                                      height: 120,
                                      width: 120),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Text(
                                      getTranslated(
                                          "contact_with_us_description",
                                          context),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 18,
                                          color: Styles.PRIMARY_COLOR)),
                                ),

                                ///Call Center
                                Text(
                                    getTranslated(
                                        "customer_service_number", context),
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.regular.copyWith(
                                        fontSize: 14,
                                        color: Styles.PRIMARY_COLOR)),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: CustomTextFormField(
                                    controller: TextEditingController(
                                        text: provider.contact?.phone),
                                    // initialValue: provider.model?.data?.phone,
                                    pSvgIcon: SvgImages.phoneIcon,
                                    read: true,
                                    addBorder: true,
                                  ),
                                ),
                                Text(
                                    getTranslated(
                                        "pleased_to_contact_with_us", context),
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.regular.copyWith(
                                        fontSize: 14,
                                        color: Styles.PRIMARY_COLOR)),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Styles.PRIMARY_COLOR,
                          ),
                        ),
                      );
              }),
            ],
          )),
    );
  }
}
