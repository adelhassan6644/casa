import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/data/api/end_points.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/styles.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import 'custom_images.dart';
import 'image_pop_up_viewer.dart';
import 'marquee_widget.dart';

class CustomButtonImagePicker extends StatelessWidget {
  const CustomButtonImagePicker({
    Key? key,
    this.imageFile,
    this.imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final File? imageFile;
  final String? imageUrl;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageFile == null && imageUrl == null)
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Styles.LIGHT_BORDER_COLOR, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: MarqueeWidget(
                      child: Text(
                        title,
                        style: AppTextStyles.regular.copyWith(
                            color: Styles.DISABLED,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  customImageIconSVG(imageName: SvgImages.pic)
                ],
              ),
            ),
          ),
        if (imageFile != null || imageUrl != null)
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Styles.LIGHT_BORDER_COLOR, width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => Future.delayed(
                        Duration.zero,
                        () => showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.75),
                            builder: (context) {
                              return ImagePopUpViewer(
                                image: imageFile ?? imageUrl,
                                isFromInternet:
                                    imageFile != null ? false : true,
                                title: "",
                              );
                            })),

                    // onTap: ()=>  Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ImageViewer(
                    //     ),
                    //   ),
                    // ),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageFile != null
                            ? Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: EndPoints.imageUrl + imageUrl!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(getTranslated("edit", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular.copyWith(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.SYSTEM_COLOR)),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
