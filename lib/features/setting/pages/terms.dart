import 'package:casa/app/core/utils/images.dart';
import 'package:casa/components/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
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
      backgroundColor: Styles.SCAFFOLD_BG,
      body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: getTranslated("terms_conditions", context)),
              Consumer<SettingProvider>(builder: (_, provider, child) {
                return !provider.isLoading
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: Dimensions.PADDING_SIZE_SMALL.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: Dimensions.PADDING_SIZE_SMALL.h,
                          ),
                          decoration: BoxDecoration(
                              color: Styles.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListAnimator(
                            data: [
                              Center(
                                child: customImageIcon(
                                    imageName: Images.check,
                                    height: 115,
                                    width: 115),
                              ),
                              Text(getTranslated("terms_description", context),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 22,
                                      color: Styles.PRIMARY_COLOR)),
                              SizedBox(height: 24.h,),
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
