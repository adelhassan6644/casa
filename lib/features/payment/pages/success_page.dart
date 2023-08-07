import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../navigation/routes.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({required this.data, Key? key}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    DateTime date = data["date"];
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: customImageIcon(
                  imageName: data["isDone"] == true
                      ? Images.success
                      : Images.cancelCircle,
                  width: data["isDone"] == true ? 215 : 150,
                  height: data["isDone"] == true ? 215 : 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Text(
                  data["isDone"] == true
                      ? "تم تأكيد الموعد"
                      : "نأسف لعدم اتمام عملية الدفع",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium
                      .copyWith(fontSize: 24, color: Styles.PRIMARY_COLOR),
                ),
              ),
              Visibility(
                visible: data["isDone"] == true,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text(
                    "تم حجز موعد جلسة ماساج \n يوم ${date.dateFormat(format: "EEEE", lang: "ar")} ${date.dateFormat(format: "dd/MM")} الساعه ${date.dateFormat(format: "hh:mm a")}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular
                        .copyWith(fontSize: 18, color: Styles.DETAILS_COLOR),
                  ),
                ),
              ),
              CustomButton(
                text: data["isDone"] == true
                    ? getTranslated("continue_browsing", context)
                    : getTranslated("please_try_again", context),
                backgroundColor: Styles.WHITE_COLOR,
                textColor: Styles.PRIMARY_COLOR,
                withShadow: true,
                onTap: () {
                  if (data["isDone"] == true) {
                    CustomNavigator.push(Routes.DASHBOARD,
                        arguments: 0, clean: true);
                  } else {
                    CustomNavigator.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
