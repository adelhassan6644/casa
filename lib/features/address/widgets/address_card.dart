import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({this.isHome = true,this.isSelect = false, Key? key}) : super(key: key);
  final bool isHome,isSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
      ),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL.h,
            horizontal: Dimensions.PADDING_SIZE_SMALL.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelect? Styles.PRIMARY_COLOR.withOpacity(0.1):Styles.WHITE_COLOR,
            border: Border.all(color:isSelect? Styles.PRIMARY_COLOR:
            Colors.transparent, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customImageIconSVG(
                  imageName: isHome ? SvgImages.house : SvgImages.buildings,
                  color: Styles.TITLE,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Text(isHome ? "عنوان البيت" : "عنوان اخر",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 16, color: Styles.SUBTITLE)),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text("حي العزيزية",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular
                    .copyWith(fontSize: 14, color: Styles.TITLE)),
          ],
        ),
      ),
    );
  }
}
