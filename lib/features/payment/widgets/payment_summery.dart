import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key, required this.price}) : super(key: key);
  final num price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(getTranslated("payment_summery", context),
              style: AppTextStyles.semiBold.copyWith(fontSize: 16)),
        ),
        _SummeryInfoView(
          title: getTranslated("cost", context),
          value: "$price",
        ),
        _SummeryInfoView(
          title: getTranslated("tax", context),
          value: '44',
        ),
        _SummeryInfoView(
          title: getTranslated("fees", context),
          value: '34',
        ),
        Container(
          decoration: BoxDecoration(
            color: Styles.PRIMARY_COLOR.withOpacity(0.2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _SummeryInfoView(
            title: getTranslated("total_amount", context),
            value: "200",
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
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.medium.copyWith(fontSize: 14)),
          Text("$value  ريال",
              style: AppTextStyles.semiBold.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
