import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/components/custom_images.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/setting_provider.dart';

class DeveloperSocialMedia extends StatelessWidget {
  const DeveloperSocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: provider.isLoading
              ? List.generate(
                  4,
                  (index) => Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: index == 0
                                ? Dimensions.PADDING_SIZE_DEFAULT.w
                                : 0),
                        child: const CustomShimmerCircleImage(
                          diameter: 25,
                        ),
                      ))
              : [
                  SizedBox(
                    width: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  customContainerSvgIcon(
                      imageName: SvgImages.faceBook,
                      height: 50.0,
                      width: 50.0,
                      radius: 100,
                      withShadow: true,
                      color: Styles.WHITE_COLOR,
                      onTap: () async {
                        await launch(
                            'fb://facewebmodal/f?href=https://${provider.model?.data?.facebook ?? ""}');
                      }),
                  const SizedBox(
                    width: 16,
                  ),
                  customContainerSvgIcon(
                      imageName: SvgImages.instagram,
                      height: 50.0,
                      width: 50.0,
                      radius: 100,
                      withShadow: true,
                      color: Styles.WHITE_COLOR,
                      onTap: () async {
                        await launch(
                            'in://${provider.model?.data?.instagram ?? ""}');
                      }),
                  const SizedBox(
                    width: 16,
                  ),
                  customContainerSvgIcon(
                      imageName: SvgImages.twitter,
                      height: 50.0,
                      width: 50.0,
                      radius: 100,
                      withShadow: true,
                      color: Styles.WHITE_COLOR,
                      onTap: () async {
                        await launch(
                            "whatsapp://send?phone=${provider.model?.data?.twitter ?? ""}");
                      }),
                  const SizedBox(
                    width: 16,
                  ),
                  customContainerSvgIcon(
                      imageName: SvgImages.tiktok,
                      height: 50.0,
                      width: 50.0,
                      radius: 100,
                      withShadow: true,
                      color: Styles.WHITE_COLOR),
                ],
        ),
      );
    });
  }
}
