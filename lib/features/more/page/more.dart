import 'package:casa/components/animated_widget.dart';
import 'package:casa/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/more/widgets/logout_button.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../widgets/more_button.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
            Dimensions.PADDING_SIZE_DEFAULT,
            (Dimensions.PADDING_SIZE_DEFAULT + context.toPadding),
            Dimensions.PADDING_SIZE_DEFAULT,
            Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            Expanded(
              child: ListAnimator(
                data: [
                  const ProfileCard(),
                  MoreButton(
                    title: getTranslated("notifications", context),
                    icon: SvgImages.notifications,
                    onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS),
                  ),
                  MoreButton(
                    title: getTranslated("favourite", context),
                    icon: SvgImages.outlineHeartIcon,
                    onTap: () => CustomNavigator.push(Routes.FAVOURITE),
                  ),
                  MoreButton(
                    title: getTranslated("addresses", context),
                    icon: SvgImages.location,
                    onTap: () => CustomNavigator.push(Routes.ADDRESS),
                  ),
                  MoreButton(
                    title: getTranslated("change_password", context),
                    icon: SvgImages.outlineLockIcon,
                    onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
                  ),
                  MoreButton(
                    title: getTranslated("contact_with_us", context),
                    icon: SvgImages.outlineMailIcon,
                    onTap: () => CustomNavigator.push(Routes.ABOUT_US),
                  ),
                  MoreButton(
                    title: getTranslated("terms_conditions", context),
                    icon: SvgImages.file,
                    onTap: () => CustomNavigator.push(Routes.TERMS),
                  ),
                  const LogoutButton(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
