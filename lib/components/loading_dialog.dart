import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';

loadingDialog() {
  return showAnimatedDialog(
    context: CustomNavigator.navigatorState.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30.0)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            Images.logo,
            height: MediaQuery.of(context).size.width * .3,
            width: MediaQuery.of(context).size.width * .3,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              "please wait",
              style: AppTextStyles.bold.copyWith(
                fontSize: 18.0,
                color: ColorResources.DISABLED,
              ),
            ),
          ),
        ]),
      );
    },
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.easeInOutBack,
    duration: const Duration(milliseconds: 700),
  );
}

spinKitDialog() {
  showDialog(
      barrierDismissible: false,
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (BuildContext context) {
        return SizedBox(
          height: context.height,
          width: context.width,
          child: const Center(
            child: Center(
              child: SpinKitFadingCircle(
                color: ColorResources.WHITE_COLOR,
                size: 50,
              ),
            ),
          ),
        );
      });
}
