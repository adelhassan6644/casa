import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_images.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../components/confirm_bottom_sheet.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';
import '../../address/widgets/address_card.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated("welcome_description", context),
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 18, color: Styles.PRIMARY_COLOR),
                      ),
                      Text(
                        "Mohamed",
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 18,
                            color: Styles.PRIMARY_COLOR,
                            height: 1),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  customContainerSvgIcon(
                      imageName: SvgImages.notifications,
                      radius: 100,
                      height: 45,
                      width: 45,
                      onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                child: InkWell(
                  onTap: () => CustomBottomSheet.show(
                      buttonText: "select_address",
                      label: getTranslated("pick_address", context),
                      list: Column(
                        children: List.generate(
                            5,
                            (index) => AddressCard(
                                  isSelect: index == 2,
                                  isHome: index != 2,
                                )),
                      ),
                      onConfirm: () => CustomNavigator.pop()),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.location,
                          height: 20,
                          width: 20,
                          color: Styles.DETAILS_COLOR),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "حي العزيزية",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Consumer<HomeProvider>(builder: (_, provider, child) {
          return Row(
              children: List.generate(
                  provider.tabs.length,
                  (index) => Expanded(
                        child: TabWidget(
                          title: provider.tabs[index],
                          isSelected: provider.currentTab == index,
                          onTab: () => provider.selectTab(index),
                        ),
                      )));
        })
      ],
    );
  }
}
