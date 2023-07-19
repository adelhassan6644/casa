import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Styles.WHITE_COLOR,
            border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
              imageName: SvgImages.lockIcon,
              height: 20,
              width: 20,
              color: Styles.HEADER,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(getTranslated("change_password", context),
                        maxLines: 1,
                        style: AppTextStyles.regular.copyWith(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.HEADER)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Styles.HEADER,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
