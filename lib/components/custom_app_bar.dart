import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/components/custom_images.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withCart;
  final bool withBack;
  final int? savedItemId;
  final bool withBorder;
  final bool withBackGround;
  final bool isOffer;
  final double? actionWidth;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.withCart = false,
      this.savedItemId,
      this.withBackGround = true,
      this.withBorder = false,
      this.withBack = true,
      this.isOffer = true,
      this.actionWidth,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              withBack
                  ? InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        CustomNavigator.pop();
                      },
                      child: Container(
                        height: actionWidth ?? 40,
                        width: actionWidth ?? 40,
                        padding: const EdgeInsets.fromLTRB(17, 10, 14, 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE_COLOR,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0XFFFAFAFA))),
                        child: Center(
                            child: customImageIconSVG(
                                imageName: SvgImages.backArrow)),
                      ))
                  : SizedBox(
                      width: actionWidth ?? 40,
                    ),
              const Expanded(child: SizedBox()),
              Text(
                title ?? "",
                style: AppTextStyles.semiBold
                    .copyWith(color: Colors.black, fontSize: 13),
              ),
              const Expanded(child: SizedBox()),
              actionChild ??
                  const SizedBox(
                    width: 40,
                  ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(15005, 50);
}
