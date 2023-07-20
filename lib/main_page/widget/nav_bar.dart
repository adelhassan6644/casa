import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/styles.dart';
import '../../app/core/utils/svg_images.dart';
import '../provider/main_page_provider.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Container(
          width: context.width,
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
              boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: const Offset(0, -2),
                spreadRadius: 2,
                blurRadius: 20)
          ],
            borderRadius: const BorderRadius.only(topRight: Radius.circular(25),topLeft:Radius.circular(25) )
          ),
          padding:  EdgeInsets.fromLTRB(12.w, 12.h,12.w,24.h),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.homeIcon,
                    isSelected: provider.selectedIndex == 0,
                    onTap: () => provider.updateDashboardIndex(0),
                    name: getTranslated("home", context),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.tasks,
                    isSelected: provider.selectedIndex == 1,
                    onTap: () => provider.updateDashboardIndex(1),
                    name: getTranslated("my_appointments", context),

                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.profileIcon,
                    isSelected: provider.selectedIndex == 2,
                    onTap: () => provider.updateDashboardIndex(2),
                    name: getTranslated("profile", context),

                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.moreIcon,
                    isSelected: provider.selectedIndex == 3,
                    withIconColor: false,
                    onTap: () => provider.updateDashboardIndex(3),
                    name: getTranslated("more", context),

                  ),
                ),
              ]));
    });
  }
}
