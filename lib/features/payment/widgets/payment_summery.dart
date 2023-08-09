import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummeryInfoView(
          title: getTranslated("cost", context),
          value: '',
        ),
        _SummeryInfoView(
          title: getTranslated("tax", context),
          value: '',
        ),
        _SummeryInfoView(
          title: getTranslated("fees", context),
          value: '',
        ),
        Container(
          decoration: BoxDecoration(
            color: Styles.PRIMARY_COLOR.withOpacity(0.2),
          ),
          child: _SummeryInfoView(
            title: getTranslated("fees", context),
            value: '',
          ),
        ),
      ],
    );
  }
}

class _SummeryInfoView extends StatelessWidget {
  const _SummeryInfoView({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.medium.copyWith(fontSize: 12)),
          Text("$value ريال",
              style: AppTextStyles.semiBold.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
