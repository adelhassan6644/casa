import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';
import 'custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    this.expand = true,
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
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: height,
        // padding: EdgeInsets.symmetric(
        //     horizontal: innerHPadding ?? Dimensions.PADDING_SIZE_DEFAULT.w,),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Styles.BORDER_COLOR
                )
            )
        ),
        child: Column(
          children: [
            Row(
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
                    getTranslated(title, context),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? Styles.PRIMARY_COLOR
                          : Styles.DETAILS_COLOR,
                    ),
                  ),
                ),

              ],
            ),
            LayoutBuilder(builder: (context, constr) {
              return Container(
                padding: EdgeInsets.zero,
                width: (expand) ? constr.maxWidth : 28,
                height: 4,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft:Radius.circular(100) ,
                    topRight: Radius.circular(100) ,
                  ),
                  color: isSelected ? Styles.PRIMARY_COLOR : Colors.transparent,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
