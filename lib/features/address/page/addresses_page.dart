import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/main_models/base_model.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../widgets/address_card.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Styles.SCAFFOLD_BG,
        body: Column(
          children: [
            CustomAppBar(
              title: getTranslated("addresses", context),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: ListAnimator(
                  data: List.generate(
                      10,
                      (index) => AddressCard(
                            isSelect: index == 2,
                            isHome: index != 2,
                          )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: CustomButton(
                text: getTranslated("add_address", context),
                onTap: () => CustomNavigator.push(Routes.MAP,
                    arguments: BaseModel(valueChanged: (v) {})),
              ),
            )
          ],
        ),
      ),
    );
  }
}
