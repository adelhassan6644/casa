import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({required this.paid, Key? key}) : super(key: key);
  final bool paid;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
                border: Border.all(color: Styles.WHITE_COLOR),
                color: paid
                    ? Colors.green.withOpacity(0.06)
                    : Colors.red.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              paid
                  ? getTranslated("paid", context)
                  : getTranslated("unpaid", context),
              style: AppTextStyles.medium
                  .copyWith(color: Styles.DETAILS_COLOR, fontSize: 14),
            )),
      ),
    );
  }
}
