import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import '../app/core/utils/images.dart';
import '../app/core/utils/svg_images.dart';
import 'custom_images.dart';

class EmptyState extends StatelessWidget {
  final String? img;
  final double? imgHeight;
  final double? emptyHeight;
  final double? imgWidth;
  final bool isSvg;
  final double? spaceBtw;
  final String? txt;
  final String? subText;

  const EmptyState({
    Key? key,
    this.emptyHeight,
    this.spaceBtw,
    this.isSvg = true,
    this.img,
    this.imgHeight,
    this.imgWidth,
    this.txt,
    this.subText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: emptyHeight ?? 500,
      child: Center(
        child: Column(
          children: [
            !isSvg
                ? customImageIcon(
                    imageName: img ?? Images.logo,
                    width: imgWidth ?? 200,
                    height:
                        imgHeight ?? 130) //width: MediaQueryHelper.width*.8,),
                : customImageIconSVG(
                    imageName: img ?? SvgImages.appLogo,
                    width: imgWidth ?? 200,
                    height: imgHeight ?? 150,
                    color: Styles.PRIMARY_COLOR),
            SizedBox(
              height: spaceBtw ?? 12.h,
            ),
            Text(txt ?? "لا يوجد بيانات !",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Styles.PRIMARY_COLOR,
                )),
            SizedBox(height: 8.h),
            Text(subText ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    color: Styles.PRIMARY_COLOR,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
