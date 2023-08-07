import 'package:casa/features/payment/repo/payment_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../provider/payment_provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

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
                  height: 24.h,
                )
              ],
            )),
      ),
    );
  }
}
