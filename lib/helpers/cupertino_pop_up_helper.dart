import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation/custom_navigation.dart';

abstract class CupertinoPopUpHelper {
  static showCupertinoTextController(
      {required TextEditingController controller,
      required String title,
      required String description,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      Function()? onSend,
      Function()? onClose}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text(title)),
          content: Column(
            children: [
              Text(
                description,
                style: AppTextStyles.regular.copyWith(fontSize: 13),
              ),
              CupertinoTextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: BoxDecoration(
                    color: const Color(0xFF767680).withOpacity(.12),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  if (onClose != null) {
                    onClose();
                  } else {
                    CustomNavigator.pop();
                  }
                },
                child: Text(
                  getTranslated(
                      "cancel", CustomNavigator.navigatorState.currentContext!),
                  style: AppTextStyles.regular.copyWith(
                      fontSize: 17, color: Styles.SYSTEM_COLOR),
                )),
            CupertinoDialogAction(
                onPressed: onSend,
                child: Text(
                  getTranslated(
                      "send", CustomNavigator.navigatorState.currentContext!),
                  style: AppTextStyles.semiBold.copyWith(
                      fontSize: 17, color: Styles.SYSTEM_COLOR),
                )),
          ],
        );
      },
    ).then((value) => onClose);
  }
}
