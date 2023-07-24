import 'package:casa/app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title, required this.icon, this.withBorder = true,
  this.onTap, Key? key})
      : super(key: key);
  final String title, icon;
  final void Function()? onTap;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: BoxDecoration(
          border: withBorder
              ? const Border(
              bottom: BorderSide(color: Styles.BORDER_COLOR, width: 1))
              : null),

      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
                imageName: icon,
                height: 24,
                width: 24,
                color: Styles.PRIMARY_COLOR),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(title,
                        maxLines: 1,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.PRIMARY_COLOR)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
