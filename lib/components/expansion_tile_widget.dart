import 'package:flutter/material.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/text_styles.dart';

class ExpansionTileWidget extends StatelessWidget {
  const ExpansionTileWidget(
      {required this.title, required this.children, this.childrenPadding, this.iconColor, Key? key})
      : super(key: key);
  final String title;
  final List<Widget> children;
  final double? childrenPadding;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppTextStyles.semiBold.copyWith(
            fontSize: 14, color: ColorResources.SECOUND_PRIMARY_COLOR),
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding:  EdgeInsets.all(childrenPadding??0),
      collapsedIconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      initiallyExpanded: true,
      iconColor: iconColor??ColorResources.SYSTEM_COLOR,
      shape: Border.all(color: Colors.transparent, width: 0, style: BorderStyle.none),
      collapsedShape: Border.all(color: Colors.transparent, width: 0, style: BorderStyle.none),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
