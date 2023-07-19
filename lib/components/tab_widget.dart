import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    required this.title,
    required this.isSelected,
    required this.onTab,
    this.iconSize,
    this.iconColor,
    this.height,
    this.backGroundColor,
    this.innerVPadding,
    this.innerHPadding,
    this.svgIcon,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  final Function() onTab;
  final String? svgIcon;
  final double? iconSize;
  final Color? iconColor;
  final double? height;
  final Color? backGroundColor;
  final double? innerVPadding, innerHPadding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: innerHPadding ?? 24.w, vertical: innerVPadding ?? 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected
                ? backGroundColor ?? Styles.SECOUND_PRIMARY_COLOR
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgIcon != null)
              customImageIconSVG(
                  imageName: svgIcon!,
                  color: isSelected
                      ? Styles.WHITE_COLOR
                      : iconColor ?? Styles.SECOUND_PRIMARY_COLOR,
                  height: iconSize?.h,
                  width: iconSize?.w),
            if (svgIcon != null) SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected
                      ? Styles.WHITE_COLOR
                      : Styles.SECOUND_PRIMARY_COLOR,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
