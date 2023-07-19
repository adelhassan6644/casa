import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import '../app/core/utils/text_styles.dart';
import 'custom_images.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double? textSize;
  final Color? textColor;
  final Color? borderColor;
  final Color backgroundColor;
  final String? svgIcon;
  final String? assetIcon;
  final Color? iconColor;
  final double? width;
  final double? height;
  final double? radius;
  final double? iconSize;
  final bool isLoading;
  final bool isError;
  final bool withBorderColor;
  final bool withShadow;

  const CustomButton(
      {Key? key,
      this.onTap,
      this.radius,
      this.height,
      this.svgIcon,
      this.assetIcon,
      this.isLoading = false,
      this.textColor,
      this.borderColor,
      this.width,
      this.iconColor,
      this.iconSize,
      this.textSize,
      this.withBorderColor = false,
      this.withShadow = false,
      required this.text,
      this.backgroundColor = Styles.PRIMARY_COLOR,
      this.isError = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (onTap != null) {
            onTap!();
          }
        },
        child: AnimatedContainer(
          width: isLoading ? 90.w : width ?? context.width,
          height: height ?? 60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: withShadow
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]
                : null,
            border: Border.all(
                color: withBorderColor
                    ? borderColor ?? Styles.PRIMARY_COLOR
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 30),
          ),
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.easeInOutSine,
          child: Center(
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: textColor ?? Styles.WHITE_COLOR,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: textSize ?? 16,
                          overflow: TextOverflow.ellipsis,
                          color: textColor ?? Styles.WHITE_COLOR,
                        ),
                      ),
                      if (assetIcon != null || svgIcon != null)
                        SizedBox(
                          width: 8.w,
                        ),
                      if (assetIcon != null)
                        customImageIcon(
                            imageName: assetIcon!,
                            color: iconColor,
                            width: iconSize ?? 20.w,
                            height: iconSize ?? 20.w),
                      if (svgIcon != null)
                        customImageIconSVG(
                            imageName: svgIcon!,
                            color: iconColor,
                            width: iconSize ?? 20.w,
                            height: iconSize ?? 20.w),
                    ],
                  ),
          ),
        ));
  }
}
