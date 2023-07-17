import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/text_styles.dart';
import 'custom_network_image.dart';

class CustomImageStack extends StatelessWidget {
  final List<String> images;
  final Color? boarderColor;
  final double? radius;
  const CustomImageStack(
      {Key? key, required this.images, this.boarderColor, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> getListLength({required List<String> images}) {
      if (images.length < 4) {
        return images;
      } else {
        return images.getRange(0, 4).toList();
      }
    }

    var widgetList = images
        .sublist(0, getListLength(images: images).length)
        .asMap()
        .map((index, value) => MapEntry(
            index,
            Padding(
              padding: EdgeInsets.only(left: 0.5 * 20 * index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomNetworkImage.circleNewWorkImage(
                      image: value,
                      radius: radius ?? 12.w,
                      color: boarderColor ?? Colors.white),
                  if (index == 3 && images.length > 4)
                    Container(
                        width: 16.w,
                        height: 16.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xff00000000).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "+${images.length - 3}",
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.white, fontSize: 10),
                        ))
                ],
              ),
            )))
        .values
        .toList();
    return Stack(
      clipBehavior: Clip.none,
      children: widgetList,
    );
  }
}
