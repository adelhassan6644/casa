import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/styles.dart';
import '../app/core/utils/svg_images.dart';
import 'custom_button.dart';
import 'custom_images.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {required this.txtBtn,
      this.txtBtn2,
      this.icon,
      this.description,
      this.onContinue,
      Key? key})
      : super(key: key);
  final void Function()? onContinue;
  final String txtBtn;
  final String? description, txtBtn2;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customImageIconSVG(imageName: (icon ?? SvgImages.alarm)),
        SizedBox(
          height: 16.h,
        ),
        if (description != null)
          Text(
            description!,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              // color: ColorResources.DETAILS_COLOR
            ),
          ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButton(
              onTap: onContinue,
              text: txtBtn,
            )),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
                child: CustomButton(
              onTap: () => CustomNavigator.pop(),
              text: txtBtn2 ?? "رجوع",
              backgroundColor: Styles.PRIMARY_COLOR.withOpacity(0.1),
              textColor: Styles.PRIMARY_COLOR,
            ))
          ],
        )
      ],
    );
  }
}
