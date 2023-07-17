import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';

class CheckConnectionDialog extends StatelessWidget {
  const CheckConnectionDialog({required this.isConnected, Key? key})
      : super(key: key);
  final bool isConnected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // isConnected? ImageWidget.assets(Images.connected,
        //     height: 90, width: 90, color: Colors.green):
        // ImageWidget.assets(Images.noConnection,
        //     height: 90, width: 90, color: Colors.red),
        SizedBox(
          height: 16.h,
        ),
        Text(
          getTranslated(isConnected ? "connected" : "no_connection", context),
          textAlign: TextAlign.center,
          style: AppTextStyles.regular.copyWith(
            fontSize: 14,
            // color: ColorResources.DETAILS_COLOR
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}
