import 'package:casa/components/animated_widget.dart';
import 'package:casa/features/payment/repo/payment_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../model/payment_body_model.dart';
import '../provider/payment_provider.dart';
import '../widgets/payment_summery.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key, required this.paymentBodyModel}) : super(key: key);
  final PaymentBodyModel paymentBodyModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => PaymentProvider(paymentRepo: sl<PaymentRepo>()),
        child: SafeArea(
            bottom: true,
            top: false,
            child: Column(
              children: [
                CustomAppBar(
                  title: getTranslated("check_out", context),
                ),
                const Expanded(
                    child: ListAnimator(
                  data: [
                    PaymentSummary(),
                  ],
                )),
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Consumer<PaymentProvider>(
                        builder: (_, provider, child) {
                      return CustomButton(
                        isLoading: provider.isCheckOut,
                        text: getTranslated("check_out", context),
                        onTap: () => provider.checkOut(),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                )
              ],
            )),
      ),
    );
  }
}
