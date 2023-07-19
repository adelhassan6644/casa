import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/styles.dart';
import '../app/core/utils/text_styles.dart';
import '../navigation/custom_navigation.dart';

class ImagePopUpViewer extends StatelessWidget {
  const ImagePopUpViewer({
    Key? key,
    required this.image,
    required this.title,
    this.isFromInternet = false,
  }) : super(key: key);

  final dynamic image;
  final String title;
  final bool isFromInternet;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Positioned(
          top: 24.h,
          right: 24.w,
          child: GestureDetector(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Container(
              width: 35.w,
              height: 35.h,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Styles.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold.copyWith(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    color: Styles.WHITE_COLOR),
              ),
              isFromInternet
                  ? Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: CustomNetworkImage.containerNewWorkImage(
                            image: image,
                            fit: BoxFit.fitWidth,
                            radius: 14,
                            width: context.width,
                            height: context.width * 1.4),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(image,
                          fit: BoxFit.fitWidth,
                          width: context.width,
                          height: context.width * 1.4),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
