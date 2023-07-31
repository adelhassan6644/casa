import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';
import 'custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    this.withBorder = true,
    required this.title,
    required this.isSelected,
    required this.onTab,
    this.iconSize,
    this.iconColor,
    this.height,
    this.width,
    this.backGroundColor,
    this.innerVPadding,
    this.innerHPadding = Dimensions.PADDING_SIZE_SMALL,
    this.svgIcon,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  final Function() onTab;
  final String? svgIcon;
  final double? iconSize;
  final Color? iconColor;
  final double? height, width;
  final Color? backGroundColor;
  final double innerHPadding;
  final double? innerVPadding;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTab,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: withBorder ? 1 : 0,
                    color: withBorder
                        ? Styles.BORDER_COLOR
                        : Colors.transparent))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: innerHPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (svgIcon != null)
                    customImageIconSVG(
                        imageName: svgIcon!,
                        color: isSelected
                            ? Styles.WHITE_COLOR
                            : iconColor ?? Styles.SECOUND_PRIMARY_COLOR,
                        height: iconSize,
                        width: iconSize),
                  if (svgIcon != null) const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? Styles.PRIMARY_COLOR
                            : Styles.DETAILS_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LayoutBuilder(builder: (context, _) {
              return Container(
                padding: EdgeInsets.zero,
                width: (width ?? 50 + (2 * innerHPadding)),
                height: 4,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
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
