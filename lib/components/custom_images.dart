import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget customImageIcon(
    {required String imageName,
    double? width,
    double? height,
    BoxFit fit = BoxFit.fill,
    color}) {
  return Image.asset(
    imageName,
    color: color,
    fit: BoxFit.fill,
    width: width ?? 30,
    height: height ?? 25,
  );
}

Widget customCircleSvgIcon(
    {String? title,
    required String imageName,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              color ?? Styles.PRIMARY_COLOR.withOpacity(0.1),
          radius: radius ?? 24.w,
          child: SvgPicture.asset(
            imageName,
          ),
        ),
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                title ?? "",
                style: AppTextStyles.medium.copyWith(
                    color: Styles.PRIMARY_COLOR, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customContainerSvgIcon(
    {required String imageName,
    Function? onTap,
    color,
    imageColor,
    bool withShadow = false,
    double? width,
    double? height,
    double? radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Container(
      height: height ?? 50,
      width: width ?? 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: withShadow
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      spreadRadius: 3,
                      blurRadius: 5)
                ]
              : null,
          color: color ?? Styles.PRIMARY_COLOR.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 12)),
      child: SvgPicture.asset(
        imageName,
        color: imageColor??Styles.PRIMARY_COLOR,
      ),
    ),
  );
}

Widget customImageIconSVG(
    {required String imageName,
    Color? color,
    double? height,
    double? width,
    Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(
      imageName,
      color: color,
      height: height,
      width: width,
    ),
  );
}
