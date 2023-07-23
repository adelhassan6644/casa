import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../auth/provider/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  final Function() onTap;
  const LogoutButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, provider, child) {
      return Padding(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: InkWell(
          onTap: () {
            onTap();
            if (provider.isLogin) {
              provider.logOut();
            } else {
              CustomNavigator.push(Routes.LOGIN, arguments: true);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.logout,
                  height: 20,
                  width: 20,
                  color: provider.isLogin ? Styles.ERORR_COLOR : Styles.ACTIVE),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          getTranslated(
                              provider.isLogin ? "logout" : "login", context),
                          maxLines: 1,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: provider.isLogin
                                  ? Styles.ERORR_COLOR
                                  : Styles.ACTIVE)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
