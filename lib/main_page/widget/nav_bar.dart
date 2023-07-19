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
      return SafeArea(
        bottom: true,
        top: false,
        child: Container(
            height: 60,
            width: context.width,
            decoration:
                BoxDecoration(color: Styles.WHITE_COLOR, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -3),
                  spreadRadius: 3,
                  blurRadius: 20)
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BottomNavBarItem(
                      svgIcon: SvgImages.homeIcon,
                      isSelected: provider.selectedIndex == 0,
                      onTap: () => provider.updateDashboardIndex(0),
                    ),
                  ),
                  Expanded(
                    child: BottomNavBarItem(
                      svgIcon: SvgImages.userIcon,
                      isSelected: provider.selectedIndex == 1,
                      onTap: () => provider.updateDashboardIndex(1),
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Expanded(
                    child: AnimatedCrossFade(
                        crossFadeState: provider.selectedIndex != 2
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 200),
                        firstChild: Center(
                          child: BottomNavBarItem(
                            svgIcon: SvgImages.casaLocationIcon,
                            isSelected: provider.selectedIndex == 2,
                            onTap: () => provider.updateDashboardIndex(2),
                          ),
                        ),
                        secondChild: const SizedBox()),
                  ),
                  Expanded(
                    child: BottomNavBarItem(
                      svgIcon: SvgImages.heartIcon,
                      isSelected: provider.selectedIndex == 3,
                      onTap: () => provider.updateDashboardIndex(3),
                    ),
                  ),
                  Expanded(
                    child: BottomNavBarItem(
                      svgIcon: SvgImages.moreIcon,
                      isSelected: provider.selectedIndex == 4,
                      withIconColor: false,
                      onTap: () {
                        provider.updateIsOpen(true);
                      },
                    ),
                  ),
                ])),
      );
    });
  }
}
