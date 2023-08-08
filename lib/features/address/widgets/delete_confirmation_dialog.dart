import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/address/provider/addresses_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../components/back_icon.dart';
import '../../../components/custom_images.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getTranslated("are_you_want_to_delete_your_address", context),
          style: AppTextStyles.semiBold
              .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 18),
        ),

        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: SubstringHighlight(
            textAlign: TextAlign.center,
            text: getTranslated("confirm_delete", context),
            term: getTranslated("delete_address", context),
            textStyle: AppTextStyles.regular
                .copyWith(color: Styles.DISABLED, fontSize: 16),
            textStyleHighlight: AppTextStyles.semiBold
                .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 16),
          ),
        ),

        ///cancellation action
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: Consumer<AddressesProvider>(builder: (_, provider, child) {
            return CustomButton(
              text: getTranslated("yes_accept", context),
              onTap: () {
                if (id != null) {
                  provider.deleteAddress(id);
                }
              },
              isLoading: provider.isDelete,
            );
          }),
        ),
        CustomButton(
          text: getTranslated("no_back_off", context),
          fIconWidget: const FilteredBackIcon(),
          iconSize: 12,
          iconColor: Styles.PRIMARY_COLOR,
          textColor: Styles.PRIMARY_COLOR,
          backgroundColor: Styles.SCAFFOLD_BG,
          onTap: () => CustomNavigator.pop(),
        ),
      ],
    );
  }
}

class CancelledDialog extends StatelessWidget {
  const CancelledDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customImageIcon(imageName: Images.sad, height: 110, width: 110),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
          child: Text(
            getTranslated("session_cancelled", context),
            style: AppTextStyles.semiBold
                .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 18),
          ),
        ),
        CustomButton(
          text: getTranslated("back", context),
          fIconWidget: const FilteredBackIcon(),
          iconSize: 12,
          iconColor: Styles.PRIMARY_COLOR,
          textColor: Styles.PRIMARY_COLOR,
          backgroundColor: Styles.SCAFFOLD_BG,
          onTap: () => CustomNavigator.pop(),
        ),
      ],
    );
  }
}
