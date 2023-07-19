import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../provider/setting_provider.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Text(getTranslated("terms_conditions", context),
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 24, color: Styles.HEADER)),
              ),
              Consumer<SettingProvider>(builder: (_, provider, child) {
                return !provider.isLoading
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: 12.h),
                          child: ListAnimator(
                            data: [
                              provider.model != null
                                  ? HtmlWidget(
                                      provider.model?.data?.terms ?? "")
                                  : EmptyState(
                                      txt: getTranslated(
                                          "something_went_wrong", context),
                                    )
                            ],
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Styles.PRIMARY_COLOR,
                          ),
                        ),
                      );
              }),
            ],
          )),
    );
  }
}
