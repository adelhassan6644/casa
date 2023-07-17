import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../provider/contact_provider.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("contact_with_us", context),
          ),
          Expanded(
              child: Consumer<ContactProvider>(builder: (_, provider, child) {
            return ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 24.h),
              physics: const BouncingScrollPhysics(),
              children: [
                CustomButton(
                  text: getTranslated("mail", context),
                  radius: 50,
                  onTap: () => provider.launchMail(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomButton(
                  text: getTranslated("twitter", context),
                  radius: 50,
                  onTap: () => provider.launchTwitter(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomButton(
                  text: getTranslated("website", context),
                  radius: 50,
                  onTap: () => provider.launchWebsite(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomButton(
                  text: getTranslated("customerـservice", context),
                  radius: 50,
                  onTap: () => provider.launchCustomerService(),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            );
          }))
        ],
      ),
    );
  }
}
