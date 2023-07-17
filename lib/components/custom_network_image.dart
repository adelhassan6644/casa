import 'package:casa/app/core/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/images.dart';
import '../data/api/end_points.dart';

class CustomNetworkImage {
  static CustomNetworkImage? _instance;

  CustomNetworkImage._internal();

  factory CustomNetworkImage() {
    _instance ??= CustomNetworkImage._internal();
    return _instance!;
  }

  ///Container Network Image with border
  static Widget containerNewWorkImage(
      {String image = "",
      double? radius,
      String? defaultImage,
      EdgeInsetsGeometry? padding,
      double? height,
      double? width,
      BoxFit? fit,
      isPlaceHolder = true,
      double? widthOfShimmer,
      Widget? imageWidget,
      bool edges = false}) {
    return CachedNetworkImage(
      imageUrl: EndPoints.imageUrl + image,
      fadeInDuration: const Duration(seconds: 1),
      fadeOutDuration: const Duration(seconds: 1),
      errorWidget: (a, b, c) => Container(
        width: width ?? 40.w,
        height: height ?? 40.h,
        decoration: BoxDecoration(
          borderRadius: edges
              ? BorderRadius.only(
                  topRight: Radius.circular(radius ?? 10),
                  topLeft: Radius.circular(radius ?? 10))
              : BorderRadius.all(Radius.circular(radius ?? 10.0)),
          image: DecorationImage(
            fit: fit ?? BoxFit.cover,
            image: Image.asset(
              defaultImage ?? Images.logo,
              fit: fit ?? BoxFit.cover,
            ).image,
          ),
        ),
        padding: padding,
        child: imageWidget,
      ),
      placeholder: (context, url) {
        return isPlaceHolder
            ? Container(
                width: width ?? 40,
                height: height ?? 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 15.w),
                  image: DecorationImage(
                    fit: fit ?? BoxFit.cover,
                    image: Image.asset(
                      defaultImage ?? Images.logo,
                      fit: fit ?? BoxFit.cover,
                    ).image,
                  ),
                ),
                child: imageWidget,
              )
            : Container();
      },
      imageBuilder: (context, provider) {
        return Container(
          width: width ?? 40,
          height: height ?? 40,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: edges
                ? BorderRadius.only(
                    topRight: Radius.circular(radius ?? 10),
                    topLeft: Radius.circular(radius ?? 10))
                : BorderRadius.all(Radius.circular(radius ?? 10.0)),
            image: DecorationImage(fit: fit ?? BoxFit.cover, image: provider),
          ),
          child: imageWidget,
        );
      },
    );
  }

  /// Circle Network Image
  static Widget circleNewWorkImage(
      {String? image,
      double? radius,
      String? defaultImage,
      bool isDefaultSvg = true,
      backGroundColor,
      color,
      double? padding}) {
    return CachedNetworkImage(
      imageUrl: image == "" || image == null
          ? "https://"
          : EndPoints.imageUrl + image,
      repeat: ImageRepeat.noRepeat,
      errorWidget: (a, c, b) => Container(
        height: radius! * 2,
        width: radius * 2,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: color != null ? Border.all(color: color, width: 1) : null,
            shape: BoxShape.circle),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backGroundColor ?? Colors.white,
          child: Image.asset(Images.logo),
        ),
      ),
      fadeInDuration: const Duration(seconds: 1),
      fadeOutDuration: const Duration(seconds: 2),
      placeholder: (context, url) => Container(
        height: radius! * 2,
        width: radius * 2,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: color != null ? Border.all(color: color, width: 1) : null,
            shape: BoxShape.circle),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backGroundColor ?? Colors.white,
          child: Image.asset(Images.logo),
        ),
      ),
      imageBuilder: (context, provider) {
        return Container(
          height: radius! * 2,
          width: radius * 2,
          padding: EdgeInsets.all(padding ?? 0),
          decoration:
              BoxDecoration(color: backGroundColor, shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: provider,
            radius: radius,
            backgroundColor: backGroundColor ?? Colors.white,
          ),
        );
      },
    );
  }

  //Asset network Image
  Widget imageNewWorkImage(
      {String? image, String? defaultImage, double? height, double? width}) {
    return CachedNetworkImage(
      imageUrl: image == "" || image == null ? "https://" : image,
      //     fadeInDuration: Duration(seconds: 2),
      errorWidget: (a, b, c) => Container(
          height: height ?? 40,
          width: width ?? 40,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      Image.asset(defaultImage ?? "assets/logo.png").image))),
      placeholder: (context, url) => Container(
          height: height ?? 40,
          width: width ?? 40,
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: Image.asset(defaultImage ?? "assets/images/logo.png")
              //         .image)
              )),
      imageBuilder: (context, provider) {
        return Container(
            height: height ?? 40,
            width: width ?? 40,
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: provider)));
      },
    );
  }
}
